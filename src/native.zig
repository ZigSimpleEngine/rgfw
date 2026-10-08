const std = @import("std");
const builtin = @import("builtin");

var safe_allocator: std.heap.SafeAllocator = .init(std.heap.page_allocator, .{});

pub const allocator = blk: {
    if (builtin.mode == .debug) {
        break :blk safe_allocator.allocator();
    } else {
        break :blk std.heap.smp_allocator;
    }
};

/// Deinitializes the backing `SafeAllocator` and reports leaks.
/// Returns `null` when the current `allocator` has no leak checking
/// (any non-`Debug` build), otherwise returns `std.heap.Check`
/// (`.ok` when everything was freed, `.leak` otherwise).
/// Call once at the very end of the program, after all frees.
pub fn tryDeinitAllocator() ?std.heap.Check {
    if (builtin.mode != .debug) return null;
    return if (safe_allocator.deinit() == 0) .ok else .leak;
}

pub fn createLogger(
    comptime buffer_size: usize,
    comptime level: std.log.Level,
    comptime scope: @TypeOf(.enum_literal),
) fn (comptime []const u8, anytype) void {
    _ = buffer_size;

    return struct {
        fn logger(
            comptime format: []const u8,
            args: anytype,
        ) void {
            const scoped = std.log.scoped(scope);

            switch (level) {
                .debug => scoped.debug(format, args),
                .info => scoped.info(format, args),
                .warn => scoped.warn(format, args),
                .err => scoped.err(format, args),
            }
        }
    }.logger;
}

pub const panic = std.debug.FullPanic(std.debug.defaultPanic);

/// Cross-platform absolute/elapsed time tracker, normalized to milliseconds.
/// `now`/`nowSeconds` report the current wall-clock time since the Unix
/// epoch; `fromStart`/`fromStartSeconds` report time elapsed since this
/// instance was created.
pub const Time = struct {
    /// Wall-clock timestamp (ms) captured at construction time.
    start_ms: i64,
    /// Rolling timestamp (ms) of the previous `delta` call (frame marker).
    last_ms: i64,

    /// Create a `Time` anchored to the current moment.
    pub fn init() Time {
        const now_ms = timestampMs();
        return .{ .start_ms = now_ms, .last_ms = now_ms };
    }

    /// Current wall-clock time in milliseconds since the Unix epoch.
    pub fn now(self: *const Time) i64 {
        _ = self;
        return timestampMs();
    }

    /// Current wall-clock time in seconds since the Unix epoch (fractional).
    pub fn nowSeconds(self: *const Time) f64 {
        _ = self;
        return timestampSeconds();
    }

    /// Milliseconds elapsed since this `Time` was created.
    pub fn fromStart(self: *const Time) i64 {
        return now(self) - self.start_ms;
    }

    /// Seconds elapsed since this `Time` was created (fractional).
    pub fn fromStartSeconds(self: *const Time) f64 {
        return @as(f64, @floatFromInt(self.fromStart())) / 1000.0;
    }

    /// Milliseconds elapsed since the previous `deltaMs` call (0 on first
    /// call), and advances the frame marker. Call once per frame.
    pub fn deltaMs(self: *Time) i64 {
        const now_ms = timestampMs();
        const delta = now_ms - self.last_ms;
        self.last_ms = now_ms;
        return delta;
    }

    /// Seconds elapsed since the previous `deltaSeconds` call (0 on first
    /// call), and advances the frame marker. Call once per frame.
    pub fn deltaSeconds(self: *Time) f64 {
        const now_sec = timestampSeconds();
        const delta = now_sec - @as(f64, @floatFromInt(self.last_ms)) / 1000.0;
        const now_ms: i64 = @intFromFloat(now_sec * 1000.0);
        self.last_ms = now_ms;
        return delta;
    }
};

extern "kernel32" fn GetSystemTimeAsFileTime(lpSystemTimeAsFileTime: *std.os.windows.FILETIME) callconv(.winapi) void;

/// Milliseconds between the Windows file-time epoch (1601-01-01) and the Unix epoch (1970-01-01).
const epoch_offset_ms: i64 = 11_644_473_600_000;
/// 100ns ticks per millisecond (FILETIME granularity).
const ticks_per_ms: u64 = 10_000;
/// 100ns ticks per second (FILETIME granularity).
const ticks_per_sec: u64 = 10_000_000;

/// Current Windows FILETIME as a u64 count of 100ns ticks since 1601-01-01.
fn filetimeTicks() u64 {
    var ft: std.os.windows.FILETIME = undefined;
    GetSystemTimeAsFileTime(&ft);
    return (@as(u64, ft.dwHighDateTime) << 32) | @as(u64, ft.dwLowDateTime);
}

/// Wall-clock time in milliseconds since the Unix epoch.
fn timestampMs() i64 {
    if (comptime builtin.target.os.tag == .windows) {
        const epoch_ms: i64 = @intCast(@divTrunc(filetimeTicks(), ticks_per_ms));
        return epoch_ms - epoch_offset_ms;
    } else {
        var ts: std.c.timespec = undefined;
        _ = std.c.clock_gettime(std.c.CLOCK.REALTIME, &ts);
        return @as(i64, ts.sec) * 1000 + @divTrunc(@as(i64, ts.nsec), 1_000_000);
    }
}

/// Wall-clock time in seconds since the Unix epoch (fractional).
fn timestampSeconds() f64 {
    if (comptime builtin.target.os.tag == .windows) {
        const ticks = filetimeTicks();
        const sec_since_1601 = @divTrunc(ticks, ticks_per_sec);
        const frac_ticks = @mod(ticks, ticks_per_sec);
        const sec_f: f64 = @floatFromInt(sec_since_1601);
        return sec_f -
            @as(f64, epoch_offset_ms) / 1000.0 +
            @as(f64, @floatFromInt(frac_ticks)) / @as(f64, @floatFromInt(ticks_per_sec));
    } else {
        var ts: std.c.timespec = undefined;
        _ = std.c.clock_gettime(std.c.CLOCK.REALTIME, &ts);
        const sec_f: f64 = @floatFromInt(ts.sec);
        const nsec_f: f64 = @floatFromInt(ts.nsec);
        return sec_f + nsec_f / @as(f64, @floatFromInt(std.time.ns_per_s));
    }
}
