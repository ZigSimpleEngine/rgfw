//! Example: create a simple window using RGFW Zig bindings.
//! Similar to the basic example in the RGFW README.

const rgfw = @import("rgfw");

pub fn main() !void {
    // Initialize the RGFW library (0 = success, negative = error, positive = warning)
    const init_result = rgfw.init(null, 0);
    if (init_result < 0) {
        @panic("RGFW init failed");
    }
    defer rgfw.deinit();

    const win = rgfw.createWindow(
        "Hello, RGFW!",
        .{ .x = 100, .y = 100 },
        .{ .w = 500, .h = 500 },
        0,
    ) orelse {
        @panic("Failed to create window");
    };
    defer win.close();

    while (!rgfw.window.shouldClose(win)) {
        rgfw.pollEvents();
    }
}
