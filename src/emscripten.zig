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

pub fn panic(msg: []const u8, error_return_trace: ?*std.builtin.StackTrace, ret_addr: ?usize) noreturn {
    _ = error_return_trace;
    _ = ret_addr;

    var buf: [1024]u8 = undefined;
    const error_msg: [:0]u8 = std.fmt.bufPrintZ(&buf, "PANIC! {s}", .{msg}) catch unreachable;
    emscripten_err(error_msg.ptr);

    while (true) {
        @breakpoint();
    }
}
