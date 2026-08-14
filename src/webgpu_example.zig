const std = @import("std");
const rgfw = @import("rgfw");

const wgpu = @cImport({
    @cInclude("webgpu/webgpu.h");
});

pub fn main() !void {
    const init_result = rgfw.init("RGFW WebGPU", .{});
    if (init_result < 0) @panic("RGFW init failed");
    defer rgfw.deinit();

    const win = rgfw.createWindow("RGFW + WebGPU", .{ .x = 100, .y = 100 }, .{ .w = 800, .h = 600 }, .{})
        orelse @panic("Failed to create window");
    defer rgfw.window.close(win);

    const instance_desc = std.mem.zeroInit(wgpu.WGPUInstanceDescriptor, .{});
    const instance = wgpu.wgpuCreateInstance(&instance_desc);
    defer wgpu.wgpuInstanceRelease(instance);

    const surface: wgpu.WGPUSurface = @ptrCast(@alignCast(
        rgfw.webgpu.createSurface(win, @ptrCast(instance)) orelse @panic("Failed to create WebGPU surface"),
    ));
    defer wgpu.wgpuSurfaceRelease(surface);

    while (!rgfw.window.shouldClose(win)) {
        rgfw.pollEvents();
    }
}
