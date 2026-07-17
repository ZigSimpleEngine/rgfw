const std = @import("std");
const builtin = @import("builtin");

pub const allocator = blk: {
    if (builtin.mode == .Debug) {
        var debug = std.heap.DebugAllocator(.{}){};

        break :blk debug.allocator();
    } else {
        break :blk std.heap.smp_allocator;
    }
};

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

pub const panic = std.debug.FullPanic;
