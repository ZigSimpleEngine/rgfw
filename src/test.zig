const std = @import("std");
const rgfw = @import("rgfw");
const opts = rgfw.opts;

test "opaque handle types" {
    _ = rgfw.Window;
    _ = rgfw.WindowSrc;
    _ = rgfw.Info;
    _ = rgfw.Surface;
    _ = rgfw.NativeImage;
    _ = rgfw.Mouse;
    _ = rgfw.Monitor;
    _ = rgfw.GlContext;
    _ = rgfw.EglContext;
    _ = rgfw.DxgiFactory;
    _ = rgfw.Unknown;
    _ = rgfw.DxgiSwapChain;
    _ = rgfw.MonitorNode;
    _ = rgfw.WlDisplay;
    _ = rgfw.WlSurface;
    _ = rgfw.WlEglWindow;
    try std.testing.expectEqual(@sizeOf(usize), @sizeOf(*rgfw.Window));
}

test "error type" {
    try std.testing.expectEqual(@typeInfo(rgfw.Error).error_set.?.len, 1);
}

test "Key enum — last field is 255, all named variants present" {
    const key = rgfw.Key;
    try std.testing.expectEqual(0, @intFromEnum(key.none));
    try std.testing.expectEqual(255, @intFromEnum(key.last));
    try std.testing.expectEqual(27, @intFromEnum(key.escape));
    try std.testing.expectEqual('a', @intFromEnum(key.a));
    try std.testing.expectEqual('z', @intFromEnum(key.z));
    try std.testing.expectEqual('0', @intFromEnum(key._0));
    try std.testing.expectEqual('9', @intFromEnum(key._9));
    try std.testing.expectEqual(130, @intFromEnum(key.f3));
    try std.testing.expectEqual(151, @intFromEnum(key.f24));
    const eq = comptime key.equals;
    const ret = comptime key.return_key;
    const peq = comptime key.pad_equals;
    _ = eq; _ = ret; _ = peq;
}

test "MouseButton enum" {
    try std.testing.expectEqual(0, @intFromEnum(rgfw.MouseButton.left));
    try std.testing.expectEqual(1, @intFromEnum(rgfw.MouseButton.middle));
    try std.testing.expectEqual(2, @intFromEnum(rgfw.MouseButton.right));
    _ = rgfw.MouseButton.final;
}

test "KeyMod packed struct" {
    const km = rgfw.KeyMod{};
    try std.testing.expectEqual(@as(u8, 0), @as(u8, @bitCast(km)));
    const km2 = rgfw.KeyMod{ .shift = true, .control = true };
    try std.testing.expectEqual(@as(u8, 0b00010100), @as(u8, @bitCast(km2)));
    _ = rgfw.KeyMod.none;
}

test "InitFlags packed struct" {
    const f = rgfw.InitFlags{ .openGl = true, .vulkan = true };
    try std.testing.expectEqual(@as(u8, 0b00000101), @as(u8, @bitCast(f)));
    _ = rgfw.InitFlags{};
}

test "Format enum" {
    try std.testing.expectEqual(0, @intFromEnum(rgfw.Format.rgb8));
    try std.testing.expectEqual(5, @intFromEnum(rgfw.Format.abgr8));
    _ = rgfw.Format.count;
}

test "common enums — ModeRequest, DndActionType, DataTransferType" {
    try std.testing.expectEqual(1, @intFromEnum(rgfw.ModeRequest.scale));
    try std.testing.expectEqual(0, @intFromEnum(rgfw.DndActionType.none));
    try std.testing.expectEqual(1, @intFromEnum(rgfw.DndActionType.enter));
    try std.testing.expectEqual(0, @intFromEnum(rgfw.DataTransferType.none));
    try std.testing.expectEqual(1, @intFromEnum(rgfw.DataTransferType.text));
}

test "EventType — every variant present" {
    try std.testing.expectEqual(0, @intFromEnum(rgfw.EventType.none));
    try std.testing.expectEqual(1, @intFromEnum(rgfw.EventType.keyPressed));
    try std.testing.expectEqual(4, @intFromEnum(rgfw.EventType.mouseButtonPressed));
    try std.testing.expectEqual(11, @intFromEnum(rgfw.EventType.windowMoved));
    try std.testing.expectEqual(20, @intFromEnum(rgfw.EventType.dataDrop));
    try std.testing.expectEqual(24, @intFromEnum(rgfw.EventType.monitorDisconnected));
    _ = rgfw.EventType.count;
}

test "EventFlag packed struct — field count" {
    comptime {
        const info = @typeInfo(rgfw.EventFlag).@"struct";
        var count: usize = 0;
        for (info.fields) |f| {
            if (!std.mem.startsWith(u8, f.name, "_")) count += 1;
        }
        try std.testing.expectEqual(24, count);
    }
}

test "WindowFlags packed struct" {
    var wf = rgfw.WindowFlags{ .noBorder = true, .fullscreen = true };
    try std.testing.expectEqual(@as(u32, 0b0000000000010001), @as(u32, @bitCast(wf)));
    wf = rgfw.WindowFlags.windowedFullscreen;
    try std.testing.expectEqual(true, wf.noBorder);
    try std.testing.expectEqual(true, wf.maximize);
    _ = rgfw.WindowFlags.transparent;
    _ = rgfw.WindowFlags.captureRawMouse;
}

test "Icon enum" {
    try std.testing.expectEqual(1, @intFromEnum(rgfw.Icon.taskbar));
    try std.testing.expectEqual(2, @intFromEnum(rgfw.Icon.window));
    try std.testing.expectEqual(3, @intFromEnum(rgfw.Icon.both));
}

test "MouseIcon enum" {
    try std.testing.expectEqual(0, @intFromEnum(rgfw.MouseIcon.normal));
    try std.testing.expectEqual(2, @intFromEnum(rgfw.MouseIcon.ibeam));
    try std.testing.expectEqual(3, @intFromEnum(rgfw.MouseIcon.crosshair));
    try std.testing.expectEqual(20, @intFromEnum(rgfw.MouseIcon.progress));
    _ = rgfw.MouseIcon.final;
    _ = rgfw.MouseIcon.count;
    _ = rgfw.MouseIcon.text;
}

test "FlashRequest enum" {
    try std.testing.expectEqual(0, @intFromEnum(rgfw.FlashRequest.cancel));
    try std.testing.expectEqual(1, @intFromEnum(rgfw.FlashRequest.briefly));
}

test "DebugType enum" {
    try std.testing.expectEqual(0, @intFromEnum(rgfw.DebugType.err));
    try std.testing.expectEqual(2, @intFromEnum(rgfw.DebugType.info));
}

test "ErrorCode enum" {
    try std.testing.expectEqual(0, @intFromEnum(rgfw.ErrorCode.none));
    try std.testing.expectEqual(1, @intFromEnum(rgfw.ErrorCode.outOfMemory));
    try std.testing.expectEqual(15, @intFromEnum(rgfw.ErrorCode.infoWindow));
    try std.testing.expectEqual(19, @intFromEnum(rgfw.ErrorCode.warningWayland));
    try std.testing.expectEqual(20, @intFromEnum(rgfw.ErrorCode.warningOpenGl));
}

test "EventWait enum" {
    try std.testing.expectEqual(0, @intFromEnum(rgfw.EventWait.eventNoWait));
    try std.testing.expectEqual(-1, @intFromEnum(rgfw.EventWait.eventWaitNext));
}

test "ColorLayout extern struct — field layout" {
    try std.testing.expectEqual(@sizeOf(i32) * 4 + @sizeOf(u32), @sizeOf(rgfw.ColorLayout));
}

test "GammaRamp extern struct" {
    try std.testing.expectEqual(usize, @TypeOf(@as(rgfw.GammaRamp, undefined).size));
}

test "MonitorMode extern struct" {
    const mm: rgfw.MonitorMode = undefined;
    try std.testing.expectEqual(i32, @TypeOf(mm.w));
    try std.testing.expectEqual(f32, @TypeOf(mm.refreshRate));
    try std.testing.expectEqual(u8, @TypeOf(mm.red));
    try std.testing.expectEqual(?*anyopaque, @TypeOf(mm.src));
}

test "Position, Size, Scale, Rect, MouseVector, Image" {
    try std.testing.expectEqual(i32, @TypeOf(@as(rgfw.Position, undefined).x));
    try std.testing.expectEqual(i32, @TypeOf(@as(rgfw.Size, undefined).w));
    try std.testing.expectEqual(f32, @TypeOf(@as(rgfw.Scale, undefined).x));
    try std.testing.expectEqual(i32, @TypeOf(@as(rgfw.Rect, undefined).x));
    try std.testing.expectEqual(f32, @TypeOf(@as(rgfw.MouseVector, undefined).x));
    _ = rgfw.Image{ .data = undefined, .w = 0, .h = 0, .format = .rgb8 };
}

test "event structs — sizes match C layout" {
    try std.testing.expectEqual(@sizeOf(rgfw.CommonEvent), @sizeOf(@TypeOf(rgfw.CommonEvent{ .type = .none })));
    _ = rgfw.WindowFocusEvent{ .state = true };
    _ = rgfw.MouseButtonEvent{ .value = .left };
    _ = rgfw.MouseDeltaEvent{ .x = 1, .y = -1 };
    _ = rgfw.MouseMotionEvent{ .x = 100, .y = 200 };
    _ = rgfw.KeyEvent{ .value = .a, .state = true };
    _ = rgfw.KeyCharEvent{ .value = 0x41 };
    _ = rgfw.DataDropEvent{};
    _ = rgfw.DataDragEvent{};
    _ = rgfw.ScaleUpdatedEvent{ .x = 1.5 };
    _ = rgfw.MonitorEvent{};
    _ = rgfw.WindowUpdateEvent{ .w = 800, .h = 600 };
}

test "Event union — tag and field access" {
    var ev = rgfw.Event{ .type = .keyPressed };
    try std.testing.expectEqual(rgfw.EventType.keyPressed, ev.type);
    ev.key = .{ .value = .space, .state = true, .repeat = false, .mod = .{} };
}

test "DataDropNode extern struct" {
    _ = rgfw.DataDropNode{ .data = null };
}

test "DataTransfer extern struct" {
    const dt = rgfw.DataTransfer{ .data = null, .length = 0, .type = .text };
    _ = dt;
}

test "Callbacks extern struct" {
    _ = rgfw.Callbacks{};
}

test "module-level functions — alloc, free, init, deinit, etc." {
    _ = &rgfw.alloc;
    _ = &rgfw.free;
    _ = &rgfw.sizeofInfo;
    _ = &rgfw.sizeofWindow;
    _ = &rgfw.sizeofWindowSrc;
    _ = &rgfw.sizeofNativeImage;
    _ = &rgfw.surface.sizeof;
    _ = &rgfw.usingWayland;
    _ = &rgfw.getLayerOsx;
    _ = &rgfw.getDisplayX11;
    _ = &rgfw.getDisplayWayland;
    _ = &rgfw.moveToMacOSResourceDir;
    _ = &rgfw.setRawMouseMode;
    _ = &rgfw.setBuildDnd;
    _ = &rgfw.waitForEvent;
    _ = &rgfw.pollEvents;
    _ = &rgfw.stopCheckEvents;
    _ = &rgfw.setQueueEvents;
    _ = &rgfw.setEventCallback;
    _ = &rgfw.getEventCallback;
    _ = &rgfw.setDualEventCallback;
    _ = &rgfw.setAllEventCallbacks;
    _ = &rgfw.createWindow;
    _ = &rgfw.createWindowPtr;
    _ = &rgfw.getGlobalMouse;
    _ = &rgfw.getMouseScroll;
    _ = &rgfw.getMouseVector;
    _ = &rgfw.isKeyPressed;
    _ = &rgfw.isKeyReleased;
    _ = &rgfw.isKeyDown;
    _ = &rgfw.isMousePressed;
    _ = &rgfw.isMouseReleased;
    _ = &rgfw.isMouseDown;
    _ = &rgfw.setRootWindow;
    _ = &rgfw.getRootWindow;
    _ = &rgfw.apiKeyToRgfw;
    _ = &rgfw.rgfwToApiKey;
    _ = &rgfw.physicalToMappedKey;
    _ = &rgfw.copyImageData;
    _ = &rgfw.checkEvent;
    _ = &rgfw.checkQueuedEvent;
    _ = &rgfw.eventQueuePush;
    _ = &rgfw.eventQueuePushAndCall;
    _ = &rgfw.isLatin;
    _ = &rgfw.decodeUtf8;
    _ = &rgfw.extensionSupportedStr;
    _ = &rgfw.extensionSupportedBase;
    _ = &rgfw.copyImageData64;
    _ = &rgfw.convertImageData64;
}

test "top-level extern type aliases" {
    _ = rgfw.Proc;
    _ = rgfw.ProcLoader;
    _ = rgfw.EventCallback;
    _ = rgfw.DebugCallback;
    _ = rgfw.ConvertCallback;
    _ = rgfw.DebugInfo;
}

test "window.* functions" {
    _ = &rgfw.window.createSurface;
    _ = &rgfw.window.createSurfacePtr;
    _ = &rgfw.window.close;
    _ = &rgfw.window.closePtr;
    _ = &rgfw.window.shouldClose;
    _ = &rgfw.window.setShouldClose;
    _ = &rgfw.window.getExitKey;
    _ = &rgfw.window.setExitKey;
    _ = &rgfw.window.getPosition;
    _ = &rgfw.window.getSize;
    _ = &rgfw.window.getSizeInPixels;
    _ = &rgfw.window.fetchSize;
    _ = &rgfw.window.getFlags;
    _ = &rgfw.window.setFlags;
    _ = &rgfw.window.setEnabledEvents;
    _ = &rgfw.window.getEnabledEvents;
    _ = &rgfw.window.setDisabledEvents;
    _ = &rgfw.window.setEventState;
    _ = &rgfw.window.getUserPtr;
    _ = &rgfw.window.setUserPtr;
    _ = &rgfw.window.getSrc;
    _ = &rgfw.window.setLayerOsx;
    _ = &rgfw.window.getViewOsx;
    _ = &rgfw.window.getWindowOsx;
    _ = &rgfw.window.getHwnd;
    _ = &rgfw.window.getHdc;
    _ = &rgfw.window.getWindowX11;
    _ = &rgfw.window.getWindowWayland;
    _ = &rgfw.window.checkEvent;
    _ = &rgfw.window.checkQueuedEvent;
    _ = &rgfw.window.isKeyPressed;
    _ = &rgfw.window.isKeyDown;
    _ = &rgfw.window.isKeyReleased;
    _ = &rgfw.window.isMousePressed;
    _ = &rgfw.window.isMouseDown;
    _ = &rgfw.window.isMouseReleased;
    _ = &rgfw.window.didMouseLeave;
    _ = &rgfw.window.didMouseEnter;
    _ = &rgfw.window.isMouseInside;
    _ = &rgfw.window.isDataDragging;
    _ = &rgfw.window.getDataDrag;
    _ = &rgfw.window.didDataDrop;
    _ = &rgfw.window.getDataDrop;
    _ = &rgfw.window.move;
    _ = &rgfw.window.resize;
    _ = &rgfw.window.moveToMonitor;
    _ = &rgfw.window.setAspectRatio;
    _ = &rgfw.window.setMinSize;
    _ = &rgfw.window.setMaxSize;
    _ = &rgfw.window.focus;
    _ = &rgfw.window.isInFocus;
    _ = &rgfw.window.raise;
    _ = &rgfw.window.maximize;
    _ = &rgfw.window.center;
    _ = &rgfw.window.minimize;
    _ = &rgfw.window.restore;
    _ = &rgfw.window.hide;
    _ = &rgfw.window.show;
    _ = &rgfw.window.flash;
    _ = &rgfw.window.setFullscreen;
    _ = &rgfw.window.setFloating;
    _ = &rgfw.window.setOpacity;
    _ = &rgfw.window.setBorder;
    _ = &rgfw.window.borderless;
    _ = &rgfw.window.setDnd;
    _ = &rgfw.window.allowsDnd;
    _ = &rgfw.window.setName;
    _ = &rgfw.window.setIcon;
    _ = &rgfw.window.setIconEx;
    _ = &rgfw.window.showMouse;
    _ = &rgfw.window.isMouseHidden;
    _ = &rgfw.window.moveMouse;
    _ = &rgfw.window.getMouse;
    _ = &rgfw.window.isFullscreen;
    _ = &rgfw.window.isHidden;
    _ = &rgfw.window.isMinimized;
    _ = &rgfw.window.isMaximized;
    _ = &rgfw.window.isFloating;
    _ = &rgfw.window.scaleToMonitor;
    _ = &rgfw.window.getMonitor;
}

test "window.setMousePassthrough — guarded by !RGFW_NO_PASSTHROUGH" {
    if (opts.rgfw_no_passthrough) return error.SkipZigTest;
    _ = &rgfw.window.setMousePassthrough;
}

test "monitor.* functions" {
    _ = &rgfw.monitor.poll;
    _ = &rgfw.monitor.freeAll;
    _ = &rgfw.monitor.getPrimary;
    _ = &rgfw.monitor.getMonitors;
    _ = &rgfw.monitor.getAll;
    _ = &rgfw.monitor.getModes;
    _ = &rgfw.monitor.getModesPtr;
    _ = &rgfw.monitor.freeModes;
    _ = &rgfw.monitor.findClosestMode;
    _ = &rgfw.monitor.getGammaRamp;
    _ = &rgfw.monitor.freeGammaRamp;
    _ = &rgfw.monitor.getGammaRampPtr;
    _ = &rgfw.monitor.setGammaRamp;
    _ = &rgfw.monitor.setGamma;
    _ = &rgfw.monitor.setGammaPtr;
    _ = &rgfw.monitor.getPosition;
    _ = &rgfw.monitor.getWorkarea;
    _ = &rgfw.monitor.getName;
    _ = &rgfw.monitor.getScale;
    _ = &rgfw.monitor.getPhysicalSize;
    _ = &rgfw.monitor.setUserPtr;
    _ = &rgfw.monitor.getUserPtr;
    _ = &rgfw.monitor.getMode;
    _ = &rgfw.monitor.requestMode;
    _ = &rgfw.monitor.setMode;
    _ = &rgfw.monitor.modeCompare;
    _ = &rgfw.monitor.scaleToWindow;
}

test "surface.* functions" {
    _ = &rgfw.surface.create;
    _ = &rgfw.surface.createPtr;
    _ = &rgfw.surface.getNativeImage;
    _ = &rgfw.surface.setConvertCallback;
    _ = &rgfw.surface.getConvertCallback;
    _ = &rgfw.surface.getConvert64Callback;
    _ = &rgfw.surface.free;
    _ = &rgfw.surface.freePtr;
    _ = &rgfw.surface.sizeof;
    _ = &rgfw.surface.nativeFormat;
    _ = &rgfw.surface.blit;
}

test "mouse.* functions" {
    _ = &rgfw.mouse.create;
    _ = &rgfw.mouse.createStandard;
    _ = &rgfw.mouse.free;
    _ = &rgfw.mouse.set;
    _ = &rgfw.mouse.setStandard;
    _ = &rgfw.mouse.setDefault;
    _ = &rgfw.mouse.setRawMode;
    _ = &rgfw.mouse.capture;
    _ = &rgfw.mouse.captureRaw;
    _ = &rgfw.mouse.isRawMode;
    _ = &rgfw.mouse.isCaptured;
}

test "clipboard.* functions" {
    _ = &rgfw.clipboard.read;
    _ = &rgfw.clipboard.readPtr;
    _ = &rgfw.clipboard.write;
}

test "debug.* functions" {
    _ = &rgfw.debug.setCallback;
    _ = &rgfw.debug.getCallback;
    _ = &rgfw.debug.callback;
}

test "eventQueue.* functions" {
    _ = &rgfw.eventQueue.push;
    _ = &rgfw.eventQueue.pushAndCall;
    _ = &rgfw.eventQueue.flush;
    _ = &rgfw.eventQueue.pop;
    _ = &rgfw.eventQueue.popWindow;
}

test "GlHints — guarded by RGFW_OPENGL or RGFW_EGL" {
    if (!opts.rgfw_opengl and !opts.rgfw_egl) return error.SkipZigTest;
    // NOTE: cannot access fields on extern struct TYPES directly in Zig 0.16;
    //       we use a value instance to probe field types
    const h: rgfw.GlHints = undefined;
    try std.testing.expectEqual(i32, @TypeOf(h.stencil));
    try std.testing.expectEqual(i32, @TypeOf(h.major));
    try std.testing.expectEqual(rgfw.GlRenderer, @TypeOf(h.renderer));
    try std.testing.expectEqual(?*rgfw.GlContext, @TypeOf(h.share));
    try std.testing.expectEqual(?*rgfw.EglContext, @TypeOf(h.shareEGL));
}

test "GlReleaseBehavior enum — guarded by RGFW_OPENGL or RGFW_EGL" {
    if (!opts.rgfw_opengl and !opts.rgfw_egl) return error.SkipZigTest;
    try std.testing.expectEqual(0, @intFromEnum(rgfw.GlReleaseBehavior.flush));
    try std.testing.expectEqual(1, @intFromEnum(rgfw.GlReleaseBehavior.none));
}

test "GlProfile enum — guarded by RGFW_OPENGL or RGFW_EGL" {
    if (!opts.rgfw_opengl and !opts.rgfw_egl) return error.SkipZigTest;
    try std.testing.expectEqual(0, @intFromEnum(rgfw.GlProfile.core));
    try std.testing.expectEqual(1, @intFromEnum(rgfw.GlProfile.forwardCompatibility));
    try std.testing.expectEqual(4, @intFromEnum(rgfw.GlProfile.web));
}

test "GlRenderer enum — guarded by RGFW_OPENGL or RGFW_EGL" {
    if (!opts.rgfw_opengl and !opts.rgfw_egl) return error.SkipZigTest;
    try std.testing.expectEqual(0, @intFromEnum(rgfw.GlRenderer.accelerated));
    try std.testing.expectEqual(1, @intFromEnum(rgfw.GlRenderer.software));
}

test "AttribStack extern struct — guarded by RGFW_OPENGL or RGFW_EGL" {
    if (!opts.rgfw_opengl and !opts.rgfw_egl) return error.SkipZigTest;
    // NOTE: cannot access fields on extern struct TYPES directly in Zig 0.16;
    //       we use a value instance to probe field types
    const s: rgfw.AttribStack = undefined;
    try std.testing.expectEqual([*c]i32, @TypeOf(s.attribs));
    try std.testing.expectEqual(usize, @TypeOf(s.count));
}

test "opengl.* functions — guarded by RGFW_OPENGL" {
    if (!opts.rgfw_opengl) return error.SkipZigTest;
    _ = &rgfw.opengl.setGlobalHints;
    _ = &rgfw.opengl.resetGlobalHints;
    _ = &rgfw.opengl.getGlobalHints;
    _ = &rgfw.opengl.createContext;
    _ = &rgfw.opengl.createContextPtr;
    _ = &rgfw.opengl.getContext;
    _ = &rgfw.opengl.deleteContext;
    _ = &rgfw.opengl.deleteContextPtr;
    _ = &rgfw.opengl.contextGetSourceContext;
    _ = &rgfw.opengl.makeCurrentWindow;
    _ = &rgfw.opengl.makeCurrentContext;
    _ = &rgfw.opengl.swapBuffers;
    _ = &rgfw.opengl.swapInterval;
    _ = &rgfw.opengl.getCurrentContext;
    _ = &rgfw.opengl.getCurrentWindow;
    _ = &rgfw.opengl.getProcAddress;
    _ = &rgfw.opengl.extensionSupported;
    _ = &rgfw.opengl.extensionSupportedPlatform;
}

test "egl.* functions — guarded by RGFW_EGL" {
    if (!opts.rgfw_egl) return error.SkipZigTest;
    _ = &rgfw.egl.createContext;
    _ = &rgfw.egl.createContextPtr;
    _ = &rgfw.egl.deleteContext;
    _ = &rgfw.egl.deleteContextPtr;
    _ = &rgfw.egl.getContext;
    _ = &rgfw.egl.getDisplay;
    _ = &rgfw.egl.contextGetSourceContext;
    _ = &rgfw.egl.contextGetSurface;
    _ = &rgfw.egl.contextWlEglWindow;
    _ = &rgfw.egl.swapBuffers;
    _ = &rgfw.egl.makeCurrentWindow;
    _ = &rgfw.egl.makeCurrentContext;
    _ = &rgfw.egl.getCurrentContext;
    _ = &rgfw.egl.getCurrentWindow;
    _ = &rgfw.egl.swapInterval;
    _ = &rgfw.egl.getProcAddress;
    _ = &rgfw.egl.extensionSupported;
    _ = &rgfw.egl.extensionSupportedPlatform;
}

test "vulkan.* functions — guarded by RGFW_VULKAN" {
    if (!opts.rgfw_vulkan) return error.SkipZigTest;
    _ = &rgfw.vulkan.getInstanceProcAddress;
    _ = &rgfw.vulkan.getRequiredInstanceExtensions;
    _ = &rgfw.vulkan.createSurface;
    _ = &rgfw.vulkan.getPhysicalDevicePresentationSupport;
}

test "directx.* functions — guarded by RGFW_DIRECTX" {
    if (!opts.rgfw_directx) return error.SkipZigTest;
    _ = &rgfw.directx.createSwapChain;
}

test "webgpu.* functions — guarded by RGFW_WEBGPU" {
    if (!opts.rgfw_webgpu) return error.SkipZigTest;
    _ = &rgfw.webgpu.createSurface;
}

test "platform.* functions" {
    _ = &rgfw.platform.createWindow;
    _ = &rgfw.platform.closeWindow;
    _ = &rgfw.platform.setMouse;
    _ = &rgfw.platform.setFlagsInternal;
    _ = &rgfw.platform.initX11;
    _ = &rgfw.platform.deinitX11;
    _ = &rgfw.platform.initWayland;
    _ = &rgfw.platform.deinitWayland;
    _ = &rgfw.platform.loadX11;
    _ = &rgfw.platform.loadWayland;
    _ = &rgfw.platform.unixGetTimeNs;
    _ = &rgfw.platform.unixStringLen;
    _ = &rgfw.platform.waitForShowEventX11;
    _ = &rgfw.platform.win32GetDarkModeState;
    _ = &rgfw.platform.win32MakeWindowDarkMode;
    _ = &rgfw.platform.win32GetMode;
    _ = &rgfw.platform.win32CreateMonitor;
    _ = &rgfw.platform.cocoaYTransform;
}

test "callbacks.* functions" {
    _ = &rgfw.callbacks.windowMaximized;
    _ = &rgfw.callbacks.windowMinimized;
    _ = &rgfw.callbacks.windowRestored;
    _ = &rgfw.callbacks.windowMoved;
    _ = &rgfw.callbacks.windowResized;
    _ = &rgfw.callbacks.windowClose;
    _ = &rgfw.callbacks.mouseMotion;
    _ = &rgfw.callbacks.rawMotion;
    _ = &rgfw.callbacks.windowRefresh;
    _ = &rgfw.callbacks.windowFocus;
    _ = &rgfw.callbacks.mouseNotify;
    _ = &rgfw.callbacks.dataDrop;
    _ = &rgfw.callbacks.dataDrag;
    _ = &rgfw.callbacks.keyChar;
    _ = &rgfw.callbacks.keyEvent;
    _ = &rgfw.callbacks.mouseButton;
    _ = &rgfw.callbacks.mouseScroll;
    _ = &rgfw.callbacks.scaleUpdated;
    _ = &rgfw.callbacks.monitor;
}

test "internals.* functions" {
    _ = &rgfw.internals.initKeycodes;
    _ = &rgfw.internals.initKeycodesPlatform;
    _ = &rgfw.internals.resetPrevState;
    _ = &rgfw.internals.resetKey;
    _ = &rgfw.internals.keyUpdateKeyMod;
    _ = &rgfw.internals.keyUpdateKeyMods;
    _ = &rgfw.internals.keyUpdateKeyModsEx;
    _ = &rgfw.internals.loadGl;
    _ = &rgfw.internals.unloadGl;
    _ = &rgfw.internals.loadEgl;
    _ = &rgfw.internals.unloadEgl;
    _ = &rgfw.internals.loadVulkan;
    _ = &rgfw.internals.unloadVulkan;
    _ = &rgfw.internals.monitorsRefresh;
    _ = &rgfw.internals.monitorsAdd;
    _ = &rgfw.internals.monitorsRemove;
    _ = &rgfw.internals.monitorNodeFree;
    _ = &rgfw.internals.setBit;
    _ = &rgfw.internals.splitBpp;
    _ = &rgfw.internals.windowShowMouseFlags;
    _ = &rgfw.internals.windowCaptureMousePlatform;
    _ = &rgfw.internals.windowSetRawMouseModePlatform;
}

test "internals.attribStack* — guarded by (RGFW_OPENGL or RGFW_EGL)" {
    if (!opts.rgfw_opengl and !opts.rgfw_egl) return error.SkipZigTest;
    _ = &rgfw.internals.attribStackInit;
    _ = &rgfw.internals.attribStackPushAttrib;
    _ = &rgfw.internals.attribStackPushAttribs;
}

test "native.* functions" {
    _ = &rgfw.native.osxInitView;
    _ = &rgfw.native.getNSScreenForDisplayUInt;
    _ = &rgfw.native.unixParseUri;
    _ = &rgfw.native.winapiWindowGetStyle;
    _ = &rgfw.native.winapiWindowGetExStyle;
    _ = &rgfw.native.xGetSystemContentDpi;
    _ = &rgfw.native.xHandleClipboardSelection;
    _ = &rgfw.native.xHandleEvent;
    _ = &rgfw.native.xImageGetFormat;
    _ = &rgfw.native.xErrorHandler;
    _ = &rgfw.native.x11IcCallback;
    _ = &rgfw.native.x11ImCallback;
    _ = &rgfw.native.x11ImInitCallback;
    _ = &rgfw.native.xGetMode;
    _ = &rgfw.native.windowGetVisual;
}
