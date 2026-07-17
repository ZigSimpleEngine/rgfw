const std = @import("std");
const builtin = @import("builtin");

var debug_allocator: std.heap.DebugAllocator(.{}) = .{};

pub const allocator: std.mem.Allocator = if (builtin.mode == .Debug)
    debug_allocator.allocator()
else
    std.heap.smp_allocator;

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

pub fn createAllocLogger(
    gpa: std.mem.Allocator,
    comptime level: std.log.Level,
    comptime scope: @TypeOf(.enum_literal),
) fn (comptime []const u8, anytype) void {
    return struct {
        fn logger(comptime format: []const u8, args: anytype) void {
            const full = std.fmt.allocPrint(gpa, format, args) catch {
                std.log.scoped(scope).err("log message too long (alloc failed)", .{});
                return;
            };
            defer gpa.free(full);
            const scoped = std.log.scoped(scope);
            switch (level) {
                .debug => scoped.debug("{s}", .{full}),
                .info => scoped.info("{s}", .{full}),
                .warn => scoped.warn("{s}", .{full}),
                .err => scoped.err("{s}", .{full}),
            }
        }
    }.logger;
}

pub const panic = std.debug.FullPanic;
