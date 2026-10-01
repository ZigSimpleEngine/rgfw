const std = @import("std");

extern fn emscripten_err([*c]const u8) void;

extern fn emmalloc_memalign(
    alignment: u32,
    size: u32,
) ?*anyopaque;

extern fn emmalloc_realloc_try(
    ptr: ?*anyopaque,
    size: u32,
) ?*anyopaque;

extern fn emmalloc_free(
    ptr: ?*anyopaque,
) void;

pub const EmmallocAllocator = struct {
    dummy: u32 = 0,

    pub fn allocator(self: *EmmallocAllocator) std.mem.Allocator {
        return .{
            .ptr = self,
            .vtable = &.{
                .alloc = alloc,
                .resize = resize,
                .remap = remap,
                .free = free,
            },
        };
    }

    fn alloc(
        ctx: *anyopaque,
        len: usize,
        align_: std.mem.Alignment,
        ra: usize,
    ) ?[*]u8 {
        _ = ctx;
        _ = ra;

        return @ptrCast(emmalloc_memalign(
            @intCast(align_.toByteUnits()),
            @intCast(len),
        ) orelse return null);
    }

    fn resize(
        ctx: *anyopaque,
        buf: []u8,
        align_: std.mem.Alignment,
        new_len: usize,
        ra: usize,
    ) bool {
        _ = ctx;
        _ = align_;
        _ = ra;

        return emmalloc_realloc_try(
            buf.ptr,
            @intCast(new_len),
        ) != null;
    }

    fn remap(
        ctx: *anyopaque,
        buf: []u8,
        align_: std.mem.Alignment,
        new_len: usize,
        ra: usize,
    ) ?[*]u8 {
        if (resize(ctx, buf, align_, new_len, ra))
            return buf.ptr;

        return null;
    }

    fn free(
        ctx: *anyopaque,
        buf: []u8,
        align_: std.mem.Alignment,
        ra: usize,
    ) void {
        _ = ctx;
        _ = align_;
        _ = ra;

        emmalloc_free(buf.ptr);
    }
};

var em_allocator = EmmallocAllocator{};

pub const allocator =
    em_allocator.allocator();

/// Emscripten backend has no leak checking, always returns `null`.
pub fn tryDeinitAllocator() ?std.heap.Check {
    return null;
}

extern fn emscripten_console_log([*:0]const u8) void;
extern fn emscripten_console_warn([*:0]const u8) void;
extern fn emscripten_console_error([*:0]const u8) void;

pub fn createLogger(
    comptime buffer_size: usize,
    comptime level: std.log.Level,
    comptime scope: @TypeOf(.enum_literal),
) fn (comptime []const u8, anytype) void {
    return struct {
        pub fn call(
            comptime format: []const u8,
            args: anytype,
        ) void {
            var buf: [buffer_size]u8 = undefined;

            const msg = if (scope == .default)
                std.fmt.bufPrintSentinel(
                    &buf,
                    "{s}: " ++ format,
                    .{level.asText()} ++ args,
                    0,
                )
            else
                std.fmt.bufPrintSentinel(
                    &buf,
                    "{s}(" ++ @tagName(scope) ++ "): " ++ format,
                    .{level.asText()} ++ args,
                    0,
                );

            const str = msg catch {
                emscripten_console_error("log message too long");
                return;
            };

            switch (level) {
                .err => emscripten_console_error(str.ptr),
                .warn => emscripten_console_warn(str.ptr),
                else => emscripten_console_log(str.ptr),
            }
        }
    }.call;
}

const EM_LOG_C_STACK: c_int = 1 << 3; // 8
const EM_LOG_JS_STACK: c_int = 1 << 4; // 16
const EM_LOG_DEMANGLE: c_int = 1 << 5; // 32 (deprecated)
const EM_LOG_NO_PATHS: c_int = 1 << 6; // 64
const EM_LOG_FUNC_PARAMS: c_int = 1 << 7; // 128

extern fn emscripten_get_callstack(
    flags: c_int,
    out: ?[*]u8,
    maxbytes: c_int,
) c_int;

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

/// Wall-clock time in milliseconds since the Unix epoch.
fn timestampMs() i64 {
    var tv: std.c.timeval = undefined;
    _ = std.c.gettimeofday(&tv, null);
    return @as(i64, tv.sec) * 1000 + @divTrunc(@as(i64, tv.usec), 1000);
}

/// Wall-clock time in seconds since the Unix epoch (fractional).
fn timestampSeconds() f64 {
    var tv: std.c.timeval = undefined;
    _ = std.c.gettimeofday(&tv, null);
    const sec_f: f64 = @floatFromInt(tv.sec);
    return sec_f + @as(f64, tv.usec) / 1_000_000.0;
}

pub fn panic(
    msg: []const u8,
    error_return_trace: ?*std.builtin.StackTrace,
    ret_addr: ?usize,
) noreturn {
    _ = error_return_trace;
    _ = ret_addr;

    var out: [32 * 1024]u8 = [_]u8{0} ** (32 * 1024);

    var writer: std.Io.Writer = .fixed(&out);

    writer.print("PANIC! {s}\n\n", .{msg}) catch {};

    const flags =
        EM_LOG_JS_STACK |
        EM_LOG_NO_PATHS;

    const pos = writer.buffered().len;

    if (pos < out.len) {
        const dst = out[pos..];

        _ = emscripten_get_callstack(
            flags,
            dst.ptr,
            @intCast(dst.len),
        );
    }

    emscripten_err(out[0..].ptr);

    while (true) {
        @breakpoint();
    }
}
