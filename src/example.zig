//! Example: create a simple window using RGFW Zig bindings.
//! Similar to the basic example in the RGFW README.
const std = @import("std");
const rgfw = @import("rgfw");

pub fn main(init: std.process.Init) !void {
    // Initialize the RGFW library (0 = success, negative = error, positive = warning)
    const init_result = rgfw.init(null, .{ .openGl = true });
    if (init_result < 0) {
        @panic("RGFW init failed");
    }
    defer rgfw.deinit();

    const win = rgfw.createWindow(
        "Hello, RGFW!",
        .{ .x = 100, .y = 100 },
        .{ .w = 500, .h = 500 },
        .{
            .openGl = true,
        },
    ) orelse {
        @panic("Failed to create window");
    };
    defer rgfw.window.close(win);

    var previousEventType: rgfw.EventType = .none;
    while (!rgfw.window.shouldClose(win)) {
        rgfw.pollEvents();
        var event: rgfw.Event = undefined;

        if (rgfw.checkEvent(&event)) {
            const eventType = event.type;
            if (previousEventType != eventType) {
                const type_string = try event.toString(init.gpa);
                defer init.gpa.free(type_string);
                std.debug.print("{s}\n", .{type_string});
                previousEventType = eventType;
            }
        }

        try rgfw.opengl.swapBuffers(win);
        // break;
    }
}
