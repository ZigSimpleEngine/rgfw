//! Zig bindings for the RGFW single-header GUI library.
//! Provides a cross-platform windowing, input, and rendering abstraction layer.
//! RGFW supports Windows (WinAPI), macOS (Cocoa), X11, and Wayland backends.
const std = @import("std");
const opts = @import("rgfw_options");
const c = @cImport({
    @cInclude("RGFW.h");
});

/// General error type for operations that may fail at runtime.
pub const Error = error{
    /// The underlying C function returned a null pointer when a valid pointer was expected.
    NullPointer,
};

/// Opaque handle to a platform window.
pub const Window = opaque {};
/// Opaque handle to the underlying platform-specific window source data.
pub const WindowSrc = opaque {};
/// Opaque handle to RGFW global state (per-instance context).
pub const Info = opaque {};
/// Opaque handle to a software-renderable surface (pixel buffer).
pub const Surface = opaque {};
/// Opaque handle to a native platform image (e.g. XImage, HBITMAP, wl_buffer).
pub const NativeImage = opaque {};
/// Opaque handle to a mouse/cursor icon.
pub const Mouse = opaque {};
/// Opaque handle to a monitor (display).
pub const Monitor = opaque {};
/// Opaque handle to a native OpenGL context.
pub const GlContext = opaque {};
/// Opaque handle to an EGL context.
pub const EglContext = opaque {};
/// Opaque handle to a DirectX IDXGIFactory (Windows only).
pub const DxgiFactory = opaque {};
/// Opaque handle to a generic COM IUnknown (DirectX helper).
pub const Unknown = opaque {};
/// Opaque handle to a DirectX IDXGISwapChain (Windows only).
pub const DxgiSwapChain = opaque {};
/// Opaque handle to a monitor list node (internal linked list).
pub const MonitorNode = opaque {};
/// Opaque handle to a Wayland display connection.
pub const WlDisplay = opaque {};
/// Opaque handle to a Wayland surface.
pub const WlSurface = opaque {};
/// Opaque handle to a Wayland EGL window.
pub const WlEglWindow = opaque {};

/// Abstract physical keycode (platform-independent mapping).
pub const Key = enum(u8) {
    none = c.RGFW_keyNULL,
    escape = c.RGFW_keyEscape,
    backtick = c.RGFW_keyBacktick,
    space = c.RGFW_keySpace,
    enter = c.RGFW_keyEnter,
    tab = c.RGFW_keyTab,
    backspace = c.RGFW_keyBackSpace,
    delete = c.RGFW_keyDelete,
    minus = c.RGFW_keyMinus,
    equal = c.RGFW_keyEqual,
    period = c.RGFW_keyPeriod,
    comma = c.RGFW_keyComma,
    slash = c.RGFW_keySlash,
    bracket = c.RGFW_keyBracket,
    close_bracket = c.RGFW_keyCloseBracket,
    semicolon = c.RGFW_keySemicolon,
    apostrophe = c.RGFW_keyApostrophe,
    backslash = c.RGFW_keyBackSlash,
    caps_lock = c.RGFW_keyCapsLock,
    shift_left = c.RGFW_keyShiftL,
    control_left = c.RGFW_keyControlL,
    alt_left = c.RGFW_keyAltL,
    super_left = c.RGFW_keySuperL,
    shift_right = c.RGFW_keyShiftR,
    control_right = c.RGFW_keyControlR,
    alt_right = c.RGFW_keyAltR,
    super_right = c.RGFW_keySuperR,
    up = c.RGFW_keyUp,
    down = c.RGFW_keyDown,
    left = c.RGFW_keyLeft,
    right = c.RGFW_keyRight,
    insert = c.RGFW_keyInsert,
    menu = c.RGFW_keyMenu,
    home = c.RGFW_keyHome,
    end = c.RGFW_keyEnd,
    page_up = c.RGFW_keyPageUp,
    page_down = c.RGFW_keyPageDown,
    num_lock = c.RGFW_keyNumLock,
    pad_slash = c.RGFW_keyPadSlash,
    pad_multiply = c.RGFW_keyPadMultiply,
    pad_plus = c.RGFW_keyPadPlus,
    pad_minus = c.RGFW_keyPadMinus,
    pad_equal = c.RGFW_keyPadEqual,
    pad_1 = c.RGFW_keyPad1,
    pad_2 = c.RGFW_keyPad2,
    pad_3 = c.RGFW_keyPad3,
    pad_4 = c.RGFW_keyPad4,
    pad_5 = c.RGFW_keyPad5,
    pad_6 = c.RGFW_keyPad6,
    pad_7 = c.RGFW_keyPad7,
    pad_8 = c.RGFW_keyPad8,
    pad_9 = c.RGFW_keyPad9,
    pad_0 = c.RGFW_keyPad0,
    pad_period = c.RGFW_keyPadPeriod,
    pad_return = c.RGFW_keyPadReturn,
    scroll_lock = c.RGFW_keyScrollLock,
    print_screen = c.RGFW_keyPrintScreen,
    pause = c.RGFW_keyPause,
    world_1 = c.RGFW_keyWorld1,
    world_2 = c.RGFW_keyWorld2,
    a = c.RGFW_keyA,
    b = c.RGFW_keyB,
    c = c.RGFW_keyC,
    d = c.RGFW_keyD,
    e = c.RGFW_keyE,
    f = c.RGFW_keyF,
    g = c.RGFW_keyG,
    h = c.RGFW_keyH,
    i = c.RGFW_keyI,
    j = c.RGFW_keyJ,
    k = c.RGFW_keyK,
    l = c.RGFW_keyL,
    m = c.RGFW_keyM,
    n = c.RGFW_keyN,
    o = c.RGFW_keyO,
    p = c.RGFW_keyP,
    q = c.RGFW_keyQ,
    r = c.RGFW_keyR,
    s = c.RGFW_keyS,
    t = c.RGFW_keyT,
    u = c.RGFW_keyU,
    v = c.RGFW_keyV,
    w = c.RGFW_keyW,
    x = c.RGFW_keyX,
    y = c.RGFW_keyY,
    z = c.RGFW_keyZ,
    _0 = c.RGFW_key0,
    _1 = c.RGFW_key1,
    _2 = c.RGFW_key2,
    _3 = c.RGFW_key3,
    _4 = c.RGFW_key4,
    _5 = c.RGFW_key5,
    _6 = c.RGFW_key6,
    _7 = c.RGFW_key7,
    _8 = c.RGFW_key8,
    _9 = c.RGFW_key9,
    f1 = c.RGFW_keyF1,
    f2 = c.RGFW_keyF2,
    f3 = c.RGFW_keyF3,
    f4 = c.RGFW_keyF4,
    f5 = c.RGFW_keyF5,
    f6 = c.RGFW_keyF6,
    f7 = c.RGFW_keyF7,
    f8 = c.RGFW_keyF8,
    f9 = c.RGFW_keyF9,
    f10 = c.RGFW_keyF10,
    f11 = c.RGFW_keyF11,
    f12 = c.RGFW_keyF12,
    f13 = c.RGFW_keyF13,
    f14 = c.RGFW_keyF14,
    f15 = c.RGFW_keyF15,
    f16 = c.RGFW_keyF16,
    f17 = c.RGFW_keyF17,
    f18 = c.RGFW_keyF18,
    f19 = c.RGFW_keyF19,
    f20 = c.RGFW_keyF20,
    f21 = c.RGFW_keyF21,
    f22 = c.RGFW_keyF22,
    f23 = c.RGFW_keyF23,
    f24 = c.RGFW_keyF24,
    f25 = c.RGFW_keyF25,
    last = 255,

    pub const equals = c.RGFW_keyEquals;
    pub const return_key = c.RGFW_keyReturn;
    pub const pad_equals = c.RGFW_keyPadEquals;
};

/// Abstract mouse button identifier.
pub const MouseButton = enum(u8) {
    left = c.RGFW_mouseLeft,
    middle = c.RGFW_mouseMiddle,
    right = c.RGFW_mouseRight,
    misc1 = c.RGFW_mouseMisc1,
    misc2 = c.RGFW_mouseMisc2,
    misc3 = c.RGFW_mouseMisc3,
    misc4 = c.RGFW_mouseMisc4,
    misc5 = c.RGFW_mouseMisc5,
    /// Total number of mouse button identifiers.
    pub const final: @This() = @enumFromInt(c.RGFW_mouseFinal);
};

/// Bitmask of active key modifiers (CapsLock, Shift, Ctrl, Alt, Super, etc.).
pub const KeyMod = packed struct(u8) {
    capsLock: bool = false,
    numLock: bool = false,
    control: bool = false,
    alt: bool = false,
    shift: bool = false,
    super_key: bool = false,
    scrollLock: bool = false,
    _: u1 = 0,

    pub const none: @This() = KeyMod{};
};

/// Flags for library initialization (OpenGL, EGL, Vulkan, X11) — bit flags.
pub const InitFlags = packed struct(u8) {
    /// Load native OpenGL on init.
    openGl: bool = false,
    /// Load EGL on init.
    egl: bool = false,
    /// Load Vulkan on init.
    vulkan: bool = false,
    /// Force X11 backend (even if Wayland is available).
    x11: bool = false,
    _: u4 = 0,
};

/// Pixel data format identifier (RGB8, RGBA8, BGRA8, etc.).
pub const Format = enum(u8) {
    rgb8 = c.RGFW_formatRGB8,
    bgr8 = c.RGFW_formatBGR8,
    rgba8 = c.RGFW_formatRGBA8,
    argb8 = c.RGFW_formatARGB8,
    bgra8 = c.RGFW_formatBGRA8,
    abgr8 = c.RGFW_formatABGR8,
    /// Total number of pixel format types.
    pub const count: Format = @enumFromInt(c.RGFW_formatCount);
};

/// Monitor mode request flags (scale, refresh rate, RGB bit depth).
pub const ModeRequest = enum(u8) {
    scale = c.RGFW_monitorScale,
    refresh = c.RGFW_monitorRefresh,
    rgb = c.RGFW_monitorRGB,
    all = c.RGFW_monitorAll,
};

/// Drag-and-drop action type (enter, move, exit).
pub const DndActionType = enum(u8) {
    none = c.RGFW_dndActionNone,
    enter = c.RGFW_dndActionEnter,
    move = c.RGFW_dndActionMove,
    exit = c.RGFW_dndActionExit,
};

/// Type of transferred data (text, file, URL, image, unknown).
pub const DataTransferType = enum(u8) {
    none = c.RGFW_dataNone,
    text = c.RGFW_dataText,
    file = c.RGFW_dataFile,
    url = c.RGFW_dataURL,
    image = c.RGFW_dataImage,
    unknown = c.RGFW_dataUnknown,
};

/// Event type identifier (keyboard, mouse, window, monitor, etc.).
pub const EventType = enum(u8) {
    /// No event.
    none = @intCast(c.RGFW_eventNone),
    /// A key was pressed.
    keyPressed = @intCast(c.RGFW_keyPressed),
    /// A key was released.
    keyReleased = @intCast(c.RGFW_keyReleased),
    /// UTF-8 character input event.
    keyChar = @intCast(c.RGFW_keyChar),
    /// A mouse button was pressed.
    mouseButtonPressed = @intCast(c.RGFW_mouseButtonPressed),
    /// A mouse button was released.
    mouseButtonReleased = @intCast(c.RGFW_mouseButtonReleased),
    /// Mouse scroll wheel moved.
    mouseScroll = @intCast(c.RGFW_mouseScroll),
    /// Mouse cursor moved within the window.
    mouseMotion = @intCast(c.RGFW_mouseMotion),
    /// Raw (unaccelerated) mouse motion delta.
    mouseRawMotion = @intCast(c.RGFW_mouseRawMotion),
    /// Mouse cursor entered the window.
    mouseEnter = @intCast(c.RGFW_mouseEnter),
    /// Mouse cursor left the window.
    mouseLeave = @intCast(c.RGFW_mouseLeave),
    /// The window was moved by the user.
    windowMoved = @intCast(c.RGFW_windowMoved),
    /// The window was resized by the user (on WASM: the browser was resized).
    windowResized = @intCast(c.RGFW_windowResized),
    /// Window gained keyboard focus.
    windowFocusIn = @intCast(c.RGFW_windowFocusIn),
    /// Window lost keyboard focus.
    windowFocusOut = @intCast(c.RGFW_windowFocusOut),
    /// Window content needs to be refreshed (e.g. expose event).
    windowRefresh = @intCast(c.RGFW_windowRefresh),
    /// User attempted to close the window.
    windowClose = @intCast(c.RGFW_windowClose),
    /// Window was maximized.
    windowMaximized = @intCast(c.RGFW_windowMaximized),
    /// Window was minimized.
    windowMinimized = @intCast(c.RGFW_windowMinimized),
    /// Window was restored from minimized/maximized state.
    windowRestored = @intCast(c.RGFW_windowRestored),
    /// Data was dropped onto the window.
    dataDrop = @intCast(c.RGFW_dataDrop),
    /// A drag-and-drop operation is in progress over the window.
    dataDrag = @intCast(c.RGFW_dataDrag),
    /// Content scale factor changed (DPI change).
    scaleUpdated = @intCast(c.RGFW_scaleUpdated),
    /// A monitor was connected.
    monitorConnected = @intCast(c.RGFW_monitorConnected),
    /// A monitor was disconnected.
    monitorDisconnected = @intCast(c.RGFW_monitorDisconnected),
    /// Total number of event types.
    count = @intCast(c.RGFW_eventCount),
};
/// Bitmask of event types to enable or disable.
pub const EventFlag = u32;
/// Wait mode for event polling (no wait, wait for next event).
pub const EventWait = i32;

/// Window creation and behavior flags — bit flags.
pub const WindowFlags = packed struct(u32) {
    noBorder: bool = false,
    noResize: bool = false,
    allowDnd: bool = false,
    hideMouse: bool = false,
    fullscreen: bool = false,
    translucent: bool = false,
    center: bool = false,
    rawMouse: bool = false,
    scaleToMonitor: bool = false,
    hide: bool = false,
    maximize: bool = false,
    centerCursor: bool = false,
    floating: bool = false,
    focusOnShow: bool = false,
    minimize: bool = false,
    focus: bool = false,
    captureMouse: bool = false,
    openGl: bool = false,
    egl: bool = false,
    _: u13 = 0,

    /// Alias for `translucent`.
    pub const transparent: WindowFlags = .{ .translucent = true };
    /// Shortcut for borderless + maximized (pseudo-fullscreen).
    pub const windowedFullscreen: WindowFlags = .{ .noBorder = true, .maximize = true };
    /// Shortcut for captured + raw mouse.
    pub const captureRawMouse: WindowFlags = .{ .captureMouse = true, .rawMouse = true };
};

/// Target icon type (taskbar, window, or both).
pub const Icon = enum(u8) {
    taskbar = c.RGFW_iconTaskbar,
    window = c.RGFW_iconWindow,
    both = c.RGFW_iconBoth,
};

/// Standard system cursor icon identifier.
pub const MouseIcon = enum(u8) {
    normal = c.RGFW_mouseNormal,
    arrow = c.RGFW_mouseArrow,
    ibeam = c.RGFW_mouseIbeam,
    crosshair = c.RGFW_mouseCrosshair,
    pointingHand = c.RGFW_mousePointingHand,
    resizeEw = c.RGFW_mouseResizeEW,
    resizeNs = c.RGFW_mouseResizeNS,
    resizeNwse = c.RGFW_mouseResizeNWSE,
    resizeNesw = c.RGFW_mouseResizeNESW,
    resizeNw = c.RGFW_mouseResizeNW,
    resizeN = c.RGFW_mouseResizeN,
    resizeNe = c.RGFW_mouseResizeNE,
    resizeE = c.RGFW_mouseResizeE,
    resizeSe = c.RGFW_mouseResizeSE,
    resizeS = c.RGFW_mouseResizeS,
    resizeSw = c.RGFW_mouseResizeSW,
    resizeW = c.RGFW_mouseResizeW,
    resizeAll = c.RGFW_mouseResizeAll,
    notAllowed = c.RGFW_mouseNotAllowed,
    wait = c.RGFW_mouseWait,
    progress = c.RGFW_mouseProgress,
    pub const final: MouseIcon = @enumFromInt(c.RGFW_mouseIconFinal);
    pub const count: MouseIcon = @enumFromInt(c.RGFW_mouseIconCount);
    /// Alias for `ibeam`.
    pub const text: @This() = .ibeam;
};

/// Window flash request type (cancel, briefly, until focused).
pub const FlashRequest = enum(u8) {
    cancel = c.RGFW_flashCancel,
    briefly = c.RGFW_flashBriefly,
    untilFocused = c.RGFW_flashUntilFocused,
};

/// Debug message severity (error, warning, info).
pub const DebugType = enum(u8) {
    err = c.RGFW_typeError,
    warning = c.RGFW_typeWarning,
    info = c.RGFW_typeInfo,
};

/// Specific error or informational code.
pub const ErrorCode = enum(u8) {
    none = c.RGFW_noError,
    outOfMemory = c.RGFW_errOutOfMemory,
    openGlContext = c.RGFW_errOpenGLContext,
    eglContext = c.RGFW_errEGLContext,
    wayland = c.RGFW_errWayland,
    x11 = c.RGFW_errX11,
    directxContext = c.RGFW_errDirectXContext,
    ioKit = c.RGFW_errIOKit,
    clipboard = c.RGFW_errClipboard,
    failedFuncLoad = c.RGFW_errFailedFuncLoad,
    buffer = c.RGFW_errBuffer,
    metal = c.RGFW_errMetal,
    platform = c.RGFW_errPlatform,
    eventQueue = c.RGFW_errEventQueue,
    noInit = c.RGFW_errNoInit,
    infoWindow = c.RGFW_infoWindow,
    infoBuffer = c.RGFW_infoBuffer,
    infoGlobal = c.RGFW_infoGlobal,
    infoOpenGl = c.RGFW_infoOpenGL,
    warningWayland = c.RGFW_warningWayland,
    warningOpenGl = c.RGFW_warningOpenGL,
};

/// OpenGL context release behavior hint.
pub const GlReleaseBehavior = enum(i32) {
    flush = c.RGFW_glReleaseFlush,
    none = c.RGFW_glReleaseNone,
};

/// OpenGL profile hint (core, compat, ES, forward-compat).
pub const GlProfile = enum(i32) {
    core = c.RGFW_glCore,
    forwardCompatibility = c.RGFW_glForwardCompatibility,
    compatibility = c.RGFW_glCompatibility,
    es = c.RGFW_glES,
    web = c.RGFW_glWeb,
};

/// OpenGL renderer hint (accelerated, software).
pub const GlRenderer = enum(i32) {
    accelerated = c.RGFW_glAccelerated,
    software = c.RGFW_glSoftware,
};

/// Describes the channel layout of a pixel format.
/// Maps byte offsets for red, green, blue, alpha and the total channel count.
pub const ColorLayout = extern struct {
    /// Byte offset for the red channel.
    r: i32,
    /// Byte offset for the green channel.
    g: i32,
    /// Byte offset for the blue channel.
    b: i32,
    /// Byte offset for the alpha channel.
    a: i32,
    /// Number of channels per pixel.
    channels: u32,
};

/// Gamma ramp data for a monitor.
/// Contains separate arrays for the red, green, and blue gamma curves.
pub const GammaRamp = extern struct {
    /// Red channel gamma values.
    red: [*]u16,
    /// Green channel gamma values.
    green: [*]u16,
    /// Blue channel gamma values.
    blue: [*]u16,
    /// Number of elements in each gamma channel array.
    size: usize,
};

/// Describes a display mode: resolution, refresh rate, and color depth.
pub const MonitorMode = extern struct {
    /// Width in screen coordinates.
    w: i32,
    /// Height in screen coordinates.
    h: i32,
    /// Refresh rate in Hz (may be floored).
    refreshRate: i32,
    /// Red channel bit depth.
    red: u8,
    /// Green channel bit depth.
    green: u8,
    /// Blue channel bit depth.
    blue: u8,
};

/// 2D integer position.
pub const Position = struct {
    /// X coordinate.
    x: i32,
    /// Y coordinate.
    y: i32,
};

/// 2D integer size (width and height).
pub const Size = struct {
    /// Width.
    w: i32,
    /// Height.
    h: i32,
};

/// 2D floating-point scale factors.
pub const Scale = struct {
    /// Scale on the X axis.
    x: f32,
    /// Scale on the Y axis.
    y: f32,
};

/// 2D integer rectangle (position + size).
pub const Rect = struct {
    /// X position.
    x: i32,
    /// Y position.
    y: i32,
    /// Width.
    w: i32,
    /// Height.
    h: i32,
};

/// 2D floating-point mouse delta/vector.
pub const MouseVector = struct {
    /// Delta on the X axis.
    x: f32,
    /// Delta on the Y axis.
    y: f32,
};

/// Describes an image: pixel data, dimensions, and format.
pub const Image = struct {
    /// Raw pixel data.
    data: []u8,
    /// Width in pixels.
    w: i32,
    /// Height in pixels.
    h: i32,
    /// Pixel format identifier.
    format: Format,
};

pub const CommonEvent = extern struct {
    type: EventType = .none,
    win: ?*Window = null,
};

pub const WindowFocusEvent = extern struct {
    type: EventType = .none,
    win: ?*Window = null,
    state: bool = false,
};
pub const MouseButtonEvent = extern struct {
    type: EventType = .none,
    win: ?*Window = null,
    value: MouseButton = .left,
    state: bool = false,
};

pub const MouseDeltaEvent = extern struct {
    type: EventType = .none,
    win: ?*Window = null,
    x: f32 = 0,
    y: f32 = 0,
};

pub const MouseMotionEvent = extern struct {
    type: EventType = .none,
    win: ?*Window = null,
    x: i32 = 0,
    y: i32 = 0,
    inWindow: bool = false,
};

pub const KeyEvent = extern struct {
    type: EventType = .none,
    win: ?*Window = null,
    value: Key = .none,
    repeat: bool = false,
    mod: KeyMod = .none,
    state: bool = false,
};

pub const KeyCharEvent = extern struct {
    type: EventType = .none,
    win: ?*Window = null,
    value: u32 = 0,
};

/// A single node in the linked list of dropped data items.
pub const DataDropNode = extern struct {
    data: [*c]const u8 = null,
    length: usize = 0,
    type: DataTransferType = .none,
    next: [*c]DataDropNode = null,
};

pub const DataDropEvent = extern struct {
    type: EventType = .none,
    win: ?*Window = null,
    value: [*c]const DataDropNode = null,
};

pub const DataDragEvent = extern struct {
    type: EventType = .none,
    win: ?*Window = null,
    x: i32 = 0,
    y: i32 = 0,
    action: DndActionType = .none,
    dataType: DataTransferType = .none,
};

pub const ScaleUpdatedEvent = extern struct {
    type: EventType = .none,
    win: ?*Window = null,
    x: f32 = 0,
    y: f32 = 0,
};

pub const MonitorEvent = extern struct {
    type: EventType = .none,
    win: ?*Window = null,
    monitor: ?*const Monitor = null,
    state: bool = false,
};

pub const WindowUpdateEvent = extern struct {
    type: EventType = .none,
    win: ?*Window = null,
    x: i32 = 0,
    y: i32 = 0,
    w: i32 = 0,
    h: i32 = 0,
};

pub fn checkEvent(event: *Event) bool {
    return boolFromC(c.RGFW_checkEvent(@ptrCast(event)));
}

pub fn checkQueuedEvent(event: *Event) bool {
    return boolFromC(c.RGFW_checkQueuedEvent(@ptrCast(event)));
}

pub fn eventQueuePush(event: *const Event) void {
    c.RGFW_eventQueuePush(@ptrCast(event));
}

pub fn eventQueuePushAndCall(event: *const Event) void {
    c.RGFW_eventQueuePushAndCall(@ptrCast(event));
}

/// Union of all possible event types. Use the `type` field to discriminate.
pub const Event = extern union {
    type: EventType,
    common: CommonEvent,
    focus: WindowFocusEvent,
    update: WindowUpdateEvent,
    button: MouseButtonEvent,
    delta: MouseDeltaEvent,
    mouse: MouseMotionEvent,
    key: KeyEvent,
    keyChar: KeyCharEvent,
    drop: DataDropEvent,
    drag: DataDragEvent,
    scale: ScaleUpdatedEvent,
    monitor: MonitorEvent,

    pub fn format(
        self: @This(),
        writer: *std.Io.Writer,
    ) std.Io.Writer.Error!void {
        switch (self.type) {
            .none => try writer.writeAll("None"),

            .keyPressed,
            .keyReleased,
            => try writer.print("{}", .{self.key}),

            .keyChar => try writer.print("{}", .{self.keyChar}),

            .mouseButtonPressed,
            .mouseButtonReleased,
            => try writer.print("{}", .{self.button}),

            .mouseScroll,
            .mouseRawMotion,
            => try writer.print("{}", .{self.delta}),

            .mouseMotion,
            .mouseEnter,
            .mouseLeave,
            => try writer.print("{}", .{self.mouse}),

            .windowMoved,
            .windowResized,
            .windowRefresh,
            .windowClose,
            .windowMaximized,
            .windowMinimized,
            .windowRestored,
            => try writer.print("{}", .{self.update}),

            .windowFocusIn,
            .windowFocusOut,
            => try writer.print("{}", .{self.focus}),

            .dataDrop => try writer.print("{}", .{self.drop}),

            .dataDrag => try writer.print("{}", .{self.drag}),

            .scaleUpdated => try writer.print("{}", .{self.scale}),

            .monitorConnected,
            .monitorDisconnected,
            => try writer.print("{}", .{self.monitor}),

            .count => unreachable,
        }
    }
};

extern fn RGFW_writeClipboard(data: *const DataTransfer) bool;

/// Describes a clipboard data transfer (data pointer, length, type).
pub const DataTransfer = extern struct {
    data: [*c]const u8 = null,
    length: usize = 0,
    type: DataTransferType = .none,

    pub const writeClipboard = RGFW_writeClipboard;
};
pub const genericFunc = ?*const fn (e: *const Event) callconv(.c) void;
/// Holds an array of callback function pointers for every event type.
pub const Callbacks = extern struct {
    arr: [25]genericFunc = @import("std").mem.zeroes([25]genericFunc),
};

/// OpenGL / EGL context creation hints (buffer sizes, profile, version, etc.).
pub const GlHints = extern struct {
    stencil: i32 = 0,
    samples: i32 = 0,
    stereo: i32 = 0,
    auxBuffers: i32 = 0,
    doubleBuffer: i32 = 0,
    red: i32 = 0,
    green: i32 = 0,
    blue: i32 = 0,
    alpha: i32 = 0,
    depth: i32 = 0,
    accumRed: i32 = 0,
    accumGreen: i32 = 0,
    accumBlue: i32 = 0,
    accumAlpha: i32 = 0,
    sRGB: bool = false,
    robustness: bool = false,
    debug: bool = false,
    noError: bool = false,
    releaseBehavior: GlReleaseBehavior = .flush,
    profile: GlProfile = .core,
    major: i32 = 0,
    minor: i32 = 0,
    share: ?*GlContext = null,
    shareEGL: ?*EglContext = null,
    renderer: GlRenderer = 0,
};

/// Generic function pointer returned by OpenGL/EGL proc-address queries.
pub const Proc = c.RGFW_proc;
/// Function pointer type for loading OpenGL/EGL/Vulkan procedures by name.
pub const ProcLoader = *const fn ([:0]const u8) callconv(.c) Proc;
/// Generic event callback function pointer.
pub const GenericFunc = c.RGFW_genericFunc;
/// Debug message callback function pointer.
pub const DebugFunc = c.RGFW_debugFunc;
/// Image data format conversion function pointer.
pub const ConvertImageDataFunc = c.RGFW_convertImageDataFunc;

/// Identifiers for every type of event that RGFW can send.
pub const eventType = struct {};

/// Bitmask flags for enabling or disabling specific event types on a window.
pub const eventFlag = struct {
    /// Enable key pressed events.
    pub const keyPressed: EventFlag = @intCast(c.RGFW_keyPressedFlag);
    /// Enable key released events.
    pub const keyReleased: EventFlag = @intCast(c.RGFW_keyReleasedFlag);
    /// Enable key character (UTF-8) events.
    pub const keyChar: EventFlag = @intCast(c.RGFW_keyCharFlag);
    /// Enable mouse scroll events.
    pub const mouseScroll: EventFlag = @intCast(c.RGFW_mouseScrollFlag);
    /// Enable mouse button pressed events.
    pub const mouseButtonPressed: EventFlag = @intCast(c.RGFW_mouseButtonPressedFlag);
    /// Enable mouse button released events.
    pub const mouseButtonReleased: EventFlag = @intCast(c.RGFW_mouseButtonReleasedFlag);
    /// Enable mouse motion events.
    pub const mouseMotion: EventFlag = @intCast(c.RGFW_mouseMotionFlag);
    /// Enable raw mouse motion events.
    pub const mouseRawMotion: EventFlag = @intCast(c.RGFW_mouseRawMotionFlag);
    /// Enable mouse enter events.
    pub const mouseEnter: EventFlag = @intCast(c.RGFW_mouseEnterFlag);
    /// Enable mouse leave events.
    pub const mouseLeave: EventFlag = @intCast(c.RGFW_mouseLeaveFlag);
    /// Enable window moved events.
    pub const windowMoved: EventFlag = @intCast(c.RGFW_windowMovedFlag);
    /// Enable window resized events.
    pub const windowResized: EventFlag = @intCast(c.RGFW_windowResizedFlag);
    /// Enable window focus-in events.
    pub const windowFocusIn: EventFlag = @intCast(c.RGFW_windowFocusInFlag);
    /// Enable window focus-out events.
    pub const windowFocusOut: EventFlag = @intCast(c.RGFW_windowFocusOutFlag);
    /// Enable window refresh events.
    pub const windowRefresh: EventFlag = @intCast(c.RGFW_windowRefreshFlag);
    /// Enable window maximized events.
    pub const windowMaximized: EventFlag = @intCast(c.RGFW_windowMaximizedFlag);
    /// Enable window minimized events.
    pub const windowMinimized: EventFlag = @intCast(c.RGFW_windowMinimizedFlag);
    /// Enable window restored events.
    pub const windowRestored: EventFlag = @intCast(c.RGFW_windowRestoredFlag);
    /// Enable scale updated events.
    pub const scaleUpdated: EventFlag = @intCast(c.RGFW_scaleUpdatedFlag);
    /// Enable window close events.
    pub const windowClose: EventFlag = @intCast(c.RGFW_windowCloseFlag);
    /// Enable data drop events.
    pub const dataDrop: EventFlag = @intCast(c.RGFW_dataDropFlag);
    /// Enable data drag events.
    pub const dataDrag: EventFlag = @intCast(c.RGFW_dataDragFlag);
    /// Enable monitor connected events.
    pub const monitorConnected: EventFlag = @intCast(c.RGFW_monitorConnectedFlag);
    /// Enable monitor disconnected events.
    pub const monitorDisconnected: EventFlag = @intCast(c.RGFW_monitorDisconnectedFlag);
    /// Alias for `mouseMotion` flag (may be removed in the future).
    pub const mousePosChanged: EventFlag = @intCast(c.RGFW_mousePosChangedFlag);
    /// All keyboard events (press, release, char).
    pub const keyEvents: EventFlag = @intCast(c.RGFW_keyEventsFlag);
    /// All mouse events (buttons, motion, scroll, enter, leave, raw motion).
    pub const mouseEvents: EventFlag = @intCast(c.RGFW_mouseEventsFlag);
    /// All window state events (move, resize, refresh, max, min, restore, scale).
    pub const windowEvents: EventFlag = @intCast(c.RGFW_windowEventsFlag);
    /// Window focus events (focus in, focus out).
    pub const windowFocusEvents: EventFlag = @intCast(c.RGFW_windowFocusEventsFlag);
    /// Drag-and-drop events (data drop, data drag).
    pub const dataDragDropEvents: EventFlag = @intCast(c.RGFW_dataDragDropEventsFlag);
    /// Monitor events (connected, disconnected).
    pub const monitorEvents: EventFlag = @intCast(c.RGFW_monitorEventsFlag);
    /// All event flags OR'd together.
    pub const all: EventFlag = @intCast(c.RGFW_allEventFlags);
};

/// Wait mode for `waitForEvent`.
pub const eventWait = struct {
    /// Do not wait; return immediately if no events are pending.
    pub const noWait: EventWait = @intCast(c.RGFW_eventNoWait);
    /// Wait until the next event arrives (block indefinitely).
    pub const waitNext: EventWait = @intCast(c.RGFW_eventWaitNext);
};

/// Drag-and-drop action types.
pub const dndAction = struct {
    /// No drag action.
    pub const none: DndActionType = @intCast(c.RGFW_dndActionNone);
    /// Data has been dragged into the window area.
    pub const enter: DndActionType = @intCast(c.RGFW_dndActionEnter);
    /// The dragged data has moved inside the window.
    pub const move: DndActionType = @intCast(c.RGFW_dndActionMove);
    /// The dragged data has left the window.
    pub const exit: DndActionType = @intCast(c.RGFW_dndActionExit);
};

/// Type of transferred data (clipboard or drag-and-drop).
pub const dataTransfer = struct {
    /// No data.
    pub const none: DataTransferType = @intCast(c.RGFW_dataNone);
    /// Plain text string.
    pub const text: DataTransferType = @intCast(c.RGFW_dataText);
    /// File path string.
    pub const file: DataTransferType = @intCast(c.RGFW_dataFile);
    /// URL string.
    pub const url: DataTransferType = @intCast(c.RGFW_dataURL);
    /// Raw image data.
    pub const image: DataTransferType = @intCast(c.RGFW_dataImage);
    /// Unknown raw data.
    pub const unknown: DataTransferType = @intCast(c.RGFW_dataUnknown);
};

/// Window creation and behavior flags (can be OR'd together).
pub const windowFlag = struct {
    /// Window has no border / frame / decorations.
    pub const noBorder: WindowFlags = @intCast(c.RGFW_windowNoBorder);
    /// Window cannot be resized by the user.
    pub const noResize: WindowFlags = @intCast(c.RGFW_windowNoResize);
    /// Window supports drag-and-drop.
    pub const allowDnd: WindowFlags = @intCast(c.RGFW_windowAllowDND);
    /// Window should hide the mouse cursor.
    pub const hideMouse: WindowFlags = @intCast(c.RGFW_windowHideMouse);
    /// Window is fullscreen by default.
    pub const fullscreen: WindowFlags = @intCast(c.RGFW_windowFullscreen);
    /// Window is translucent (best on X11/macOS).
    pub const translucent: WindowFlags = @intCast(c.RGFW_windowTranslucent);
    /// Alias for `translucent`.
    pub const transparent: WindowFlags = @intCast(c.RGFW_windowTransparent);
    /// Center the window on the screen.
    pub const center: WindowFlags = @intCast(c.RGFW_windowCenter);
    /// Use raw mouse input mode.
    pub const rawMouse: WindowFlags = @intCast(c.RGFW_windowRawMouse);
    /// Scale the window to match the monitor's DPI.
    pub const scaleToMonitor: WindowFlags = @intCast(c.RGFW_windowScaleToMonitor);
    /// Window starts hidden.
    pub const hide: WindowFlags = @intCast(c.RGFW_windowHide);
    /// Maximize the window on creation.
    pub const maximize: WindowFlags = @intCast(c.RGFW_windowMaximize);
    /// Center the cursor on the window on creation.
    pub const centerCursor: WindowFlags = @intCast(c.RGFW_windowCenterCursor);
    /// Create a floating (always-on-top) window.
    pub const floating: WindowFlags = @intCast(c.RGFW_windowFloating);
    /// Focus the window when it is shown.
    pub const focusOnShow: WindowFlags = @intCast(c.RGFW_windowFocusOnShow);
    /// Minimize the window on creation.
    pub const minimize: WindowFlags = @intCast(c.RGFW_windowMinimize);
    /// Window starts in focus (if possible).
    pub const focus: WindowFlags = @intCast(c.RGFW_windowFocus);
    /// Capture the mouse on window creation.
    pub const captureMouse: WindowFlags = @intCast(c.RGFW_windowCaptureMouse);
    /// Create an OpenGL context with the window.
    pub const openGl: WindowFlags = @intCast(c.RGFW_windowOpenGL);
    /// Create an EGL context with the window.
    pub const egl: WindowFlags = @intCast(c.RGFW_windowEGL);
    /// Shortcut for borderless + maximized (pseudo-fullscreen).
    pub const windowedFullscreen: WindowFlags = @intCast(c.RGFW_windowedFullscreen);
    /// Shortcut for captured + raw mouse.
    pub const captureRawMouse: WindowFlags = @intCast(c.RGFW_windowCaptureRawMouse);
};

/// Target icon type for `window.setIconEx`.
pub const icon = struct {
    /// Set the taskbar icon only.
    pub const taskbar: Icon = @intCast(c.RGFW_iconTaskbar);
    /// Set the window icon only.
    pub const window: Icon = @intCast(c.RGFW_iconWindow);
    /// Set both the taskbar and window icons.
    pub const both: Icon = @intCast(c.RGFW_iconBoth);
};

/// Standard system cursor icon identifiers.
pub const mouseIcon = struct {
    /// Normal pointer.
    pub const normal: MouseIcon = @intCast(c.RGFW_mouseNormal);
    /// Arrow cursor.
    pub const arrow: MouseIcon = @intCast(c.RGFW_mouseArrow);
    /// I-beam text selection cursor.
    pub const ibeam: MouseIcon = @intCast(c.RGFW_mouseIbeam);
    /// Alias for `ibeam`.
    pub const text: MouseIcon = @intCast(c.RGFW_mouseText);
    /// Crosshair cursor.
    pub const crosshair: MouseIcon = @intCast(c.RGFW_mouseCrosshair);
    /// Pointing hand cursor.
    pub const pointingHand: MouseIcon = @intCast(c.RGFW_mousePointingHand);
    /// East-west resize cursor.
    pub const resizeEw: MouseIcon = @intCast(c.RGFW_mouseResizeEW);
    /// North-south resize cursor.
    pub const resizeNs: MouseIcon = @intCast(c.RGFW_mouseResizeNS);
    /// Northwest-southeast resize cursor.
    pub const resizeNwse: MouseIcon = @intCast(c.RGFW_mouseResizeNWSE);
    /// Northeast-southwest resize cursor.
    pub const resizeNesw: MouseIcon = @intCast(c.RGFW_mouseResizeNESW);
    /// Northwest resize cursor.
    pub const resizeNw: MouseIcon = @intCast(c.RGFW_mouseResizeNW);
    /// North resize cursor.
    pub const resizeN: MouseIcon = @intCast(c.RGFW_mouseResizeN);
    /// Northeast resize cursor.
    pub const resizeNe: MouseIcon = @intCast(c.RGFW_mouseResizeNE);
    /// East resize cursor.
    pub const resizeE: MouseIcon = @intCast(c.RGFW_mouseResizeE);
    /// Southeast resize cursor.
    pub const resizeSe: MouseIcon = @intCast(c.RGFW_mouseResizeSE);
    /// South resize cursor.
    pub const resizeS: MouseIcon = @intCast(c.RGFW_mouseResizeS);
    /// Southwest resize cursor.
    pub const resizeSw: MouseIcon = @intCast(c.RGFW_mouseResizeSW);
    /// West resize cursor.
    pub const resizeW: MouseIcon = @intCast(c.RGFW_mouseResizeW);
    /// Resize all / move cursor.
    pub const resizeAll: MouseIcon = @intCast(c.RGFW_mouseResizeAll);
    /// Not allowed cursor.
    pub const notAllowed: MouseIcon = @intCast(c.RGFW_mouseNotAllowed);
    /// Wait / busy cursor.
    pub const wait: MouseIcon = @intCast(c.RGFW_mouseWait);
    /// Progress (working in background) cursor.
    pub const progress: MouseIcon = @intCast(c.RGFW_mouseProgress);
    /// Number of standard mouse icon types.
    pub const count: MouseIcon = @intCast(c.RGFW_mouseIconCount);
    /// Padding value for alignment.
    pub const final: MouseIcon = @intCast(c.RGFW_mouseIconFinal);
};

/// Window flash request types.
pub const flashRequest = struct {
    /// Cancel any pending flash.
    pub const cancel: FlashRequest = @intCast(c.RGFW_flashCancel);
    /// Flash the window briefly to draw attention.
    pub const briefly: FlashRequest = @intCast(c.RGFW_flashBriefly);
    /// Flash the window until it gains focus.
    pub const untilFocused: FlashRequest = @intCast(c.RGFW_flashUntilFocused);
};

/// Debug message severity levels.
pub const debugType = struct {
    /// Error message.
    pub const err: DebugType = @intCast(c.RGFW_typeError);
    /// Warning message.
    pub const warning: DebugType = @intCast(c.RGFW_typeWarning);
    /// Informational message.
    pub const info: DebugType = @intCast(c.RGFW_typeInfo);
};

/// Specific error and informational codes returned by RGFW.
pub const errorCode = struct {
    /// No error.
    pub const none: ErrorCode = @intCast(c.RGFW_noError);
    /// Out of memory.
    pub const outOfMemory: ErrorCode = @intCast(c.RGFW_errOutOfMemory);
    /// Native OpenGL context creation failed.
    pub const openGlContext: ErrorCode = @intCast(c.RGFW_errOpenGLContext);
    /// EGL context creation failed.
    pub const eglContext: ErrorCode = @intCast(c.RGFW_errEGLContext);
    /// Wayland initialization failed.
    pub const wayland: ErrorCode = @intCast(c.RGFW_errWayland);
    /// X11 initialization failed.
    pub const x11: ErrorCode = @intCast(c.RGFW_errX11);
    /// DirectX context creation failed.
    pub const directxContext: ErrorCode = @intCast(c.RGFW_errDirectXContext);
    /// IOKit initialization failed (macOS).
    pub const ioKit: ErrorCode = @intCast(c.RGFW_errIOKit);
    /// Clipboard operation failed.
    pub const clipboard: ErrorCode = @intCast(c.RGFW_errClipboard);
    /// Failed to load a required function/library.
    pub const failedFuncLoad: ErrorCode = @intCast(c.RGFW_errFailedFuncLoad);
    /// Buffer creation failed.
    pub const buffer: ErrorCode = @intCast(c.RGFW_errBuffer);
    /// Metal API error.
    pub const metal: ErrorCode = @intCast(c.RGFW_errMetal);
    /// Platform-specific error.
    pub const platform: ErrorCode = @intCast(c.RGFW_errPlatform);
    /// Event queue limit reached.
    pub const eventQueue: ErrorCode = @intCast(c.RGFW_errEventQueue);
    /// RGFW context not initialized.
    pub const noInit: ErrorCode = @intCast(c.RGFW_errNoInit);
    /// Informational: window created/freed.
    pub const infoWindow: ErrorCode = @intCast(c.RGFW_infoWindow);
    /// Informational: buffer operation.
    pub const infoBuffer: ErrorCode = @intCast(c.RGFW_infoBuffer);
    /// Informational: global context operation.
    pub const infoGlobal: ErrorCode = @intCast(c.RGFW_infoGlobal);
    /// Informational: OpenGL context operation.
    pub const infoOpenGl: ErrorCode = @intCast(c.RGFW_infoOpenGL);
    /// Warning: Wayland fallback.
    pub const warningWayland: ErrorCode = @intCast(c.RGFW_warningWayland);
    /// Warning: OpenGL operation.
    pub const warningOpenGl: ErrorCode = @intCast(c.RGFW_warningOpenGL);
};

/// OpenGL context release behavior hints.
pub const glReleaseBehavior = struct {
    /// Flush the pipeline when the context is released.
    pub const flush: GlReleaseBehavior = @intCast(c.RGFW_glReleaseFlush);
    /// Do nothing on release.
    pub const none: GlReleaseBehavior = @intCast(c.RGFW_glReleaseNone);
};

/// OpenGL profile hints for context creation.
pub const glProfile = struct {
    /// Core profile (only the requested version features).
    pub const core: GlProfile = @intCast(c.RGFW_glCore);
    /// Forward-compatible profile (no deprecated features).
    pub const forwardCompatibility: GlProfile = @intCast(c.RGFW_glForwardCompatibility);
    /// Compatibility profile (all features up to the requested version).
    pub const compatibility: GlProfile = @intCast(c.RGFW_glCompatibility);
    /// OpenGL ES profile.
    pub const es: GlProfile = @intCast(c.RGFW_glES);
    /// WebGL profile (version is mapped to GLES equivalent).
    pub const web: GlProfile = @intCast(c.RGFW_glWeb);
};

/// OpenGL renderer hints.
pub const glRenderer = struct {
    /// Hardware-accelerated (GPU) rendering.
    pub const accelerated: GlRenderer = @intCast(c.RGFW_glAccelerated);
    /// Software (CPU) rendering.
    pub const software: GlRenderer = @intCast(c.RGFW_glSoftware);
};

/// Convert a Zig `bool` to a C `RGFW_bool` (u8: 0 or 1).
fn boolToC(value: bool) c.RGFW_bool {
    return if (value) c.RGFW_TRUE else c.RGFW_FALSE;
}

/// Convert a C `RGFW_bool` (u8) to a Zig `bool`.
fn boolFromC(value: c.RGFW_bool) bool {
    return value != c.RGFW_FALSE;
}

/// Cast a pointer between two types (used for opaque handle conversions).
fn ptrCast(comptime T: type, ptr: anytype) T {
    return @ptrCast(ptr);
}

/// Convert a Zig `*Window` opaque handle to a C `*c.RGFW_window`.
fn cWindow(window_ptr: *Window) *c.RGFW_window {
    return ptrCast(*c.RGFW_window, window_ptr);
}

/// Convert a nullable C `*c.RGFW_window` to a Zig `?*Window` opaque handle.
fn zigWindow(window_ptr: ?*c.RGFW_window) ?*Window {
    return if (window_ptr) |ptr| ptrCast(*Window, ptr) else null;
}

/// Convert a Zig `*Monitor` opaque handle to a C `*c.RGFW_monitor`.
fn cMonitor(monitor_ptr: *Monitor) *c.RGFW_monitor {
    return ptrCast(*c.RGFW_monitor, monitor_ptr);
}

/// Convert a nullable C `*c.RGFW_monitor` to a Zig `?*Monitor` opaque handle.
fn zigMonitor(monitor_ptr: ?*c.RGFW_monitor) ?*Monitor {
    return if (monitor_ptr) |ptr| ptrCast(*Monitor, ptr) else null;
}

/// Convert a Zig `*MonitorMode` to a C `*c.RGFW_monitorMode`.
fn cMonitorMode(mode: *MonitorMode) *c.RGFW_monitorMode {
    return ptrCast(*c.RGFW_monitorMode, mode);
}

/// Convert a Zig `*MonitorNode` opaque handle to a C `*c.RGFW_monitorNode`.
fn cMonitorNode(node: *MonitorNode) *c.RGFW_monitorNode {
    return ptrCast(*c.RGFW_monitorNode, node);
}

/// Convert a nullable C `*c.RGFW_monitorNode` to a Zig `?*MonitorNode` opaque handle.
fn zigMonitorNode(node: ?*c.RGFW_monitorNode) ?*MonitorNode {
    return if (node) |ptr| ptrCast(*MonitorNode, ptr) else null;
}

/// Convert a Zig `*Surface` opaque handle to a C `*c.RGFW_surface`.
fn cSurface(surface_ptr: *Surface) *c.RGFW_surface {
    return ptrCast(*c.RGFW_surface, surface_ptr);
}

/// Convert a nullable C `*c.RGFW_surface` to a Zig `?*Surface` opaque handle.
fn zigSurface(surface_ptr: ?*c.RGFW_surface) ?*Surface {
    return if (surface_ptr) |ptr| ptrCast(*Surface, ptr) else null;
}

/// Convert a Zig `*Mouse` opaque handle to a C `*c.RGFW_mouse`.
fn cMouse(mouse_ptr: *Mouse) *c.RGFW_mouse {
    return ptrCast(*c.RGFW_mouse, mouse_ptr);
}

/// Convert a nullable C `*c.RGFW_mouse` to a Zig `?*Mouse` opaque handle.
fn zigMouse(mouse_ptr: ?*c.RGFW_mouse) ?*Mouse {
    return if (mouse_ptr) |ptr| ptrCast(*Mouse, ptr) else null;
}

/// Convert a nullable Zig string to a C-style null-terminated string pointer.
fn optionalCString(text: ?[:0]const u8) [*c]const u8 {
    return if (text) |s| s.ptr else null;
}

/// Convert a Zig `*Info` opaque handle to a C `*c.RGFW_info`.
fn cInfo(info: *Info) *c.RGFW_info {
    return ptrCast(*c.RGFW_info, info);
}

/// Convert a nullable C `*c.RGFW_info` to a Zig `?*Info` opaque handle.
fn zigInfo(info: ?*c.RGFW_info) ?*Info {
    return if (info) |ptr| ptrCast(*Info, ptr) else null;
}

/// Convert a Zig `*GlContext` opaque handle to a C `*c.RGFW_glContext`.
fn cGlContext(ctx: *GlContext) *c.RGFW_glContext {
    return ptrCast(*c.RGFW_glContext, ctx);
}

/// Convert a nullable C `*c.RGFW_glContext` to a Zig `?*GlContext` opaque handle.
fn zigGlContext(ctx: ?*c.RGFW_glContext) ?*GlContext {
    return if (ctx) |ptr| ptrCast(*GlContext, ptr) else null;
}

/// Convert a Zig `*EglContext` opaque handle to a C `*c.RGFW_eglContext`.
fn cEglContext(ctx: *EglContext) *c.RGFW_eglContext {
    return ptrCast(*c.RGFW_eglContext, ctx);
}

/// Convert a nullable C `*c.RGFW_eglContext` to a Zig `?*EglContext` opaque handle.
fn zigEglContext(ctx: ?*c.RGFW_eglContext) ?*EglContext {
    return if (ctx) |ptr| ptrCast(*EglContext, ptr) else null;
}

/// Allocate memory using the allocator defined at compile time (defaults to `malloc`).
/// The deallocator is `free()`.
pub fn alloc(size: usize) ?*anyopaque {
    return c.RGFW_alloc(size);
}

/// Free memory allocated by `alloc()` using the deallocator defined at compile time.
pub fn free(ptr: ?*anyopaque) void {
    c.RGFW_free(ptr);
}

/// Initialize the RGFW library (uses a static internal context).
/// `class_name` is used as the application class name (e.g. "MyApp").
/// `flags` control which subsystems to load (OpenGL, EGL, Vulkan, X11).
/// Returns 0 on success, negative on error, positive on warning.
pub fn init(class_name: ?[:0]const u8, flags: InitFlags) i32 {
    return @intCast(c.RGFW_init(optionalCString(class_name), @as(u8, @bitCast(flags))));
}

/// Initialize RGFW using a user-provided `Info` structure.
/// Useful for managing multiple independent RGFW contexts.
/// Returns 0 on success, negative on error, positive on warning.
pub fn initPtr(class_name: ?[:0]const u8, flags: InitFlags, info: *Info) i32 {
    return @intCast(c.RGFW_init_ptr(optionalCString(class_name), @as(u8, @bitCast(flags)), cInfo(info)));
}

/// Deinitialize the default RGFW context and free all associated resources.
pub fn deinit() void {
    c.RGFW_deinit();
}

/// Deinitialize a specific RGFW context identified by `info`.
pub fn deinitPtr(info: *Info) void {
    c.RGFW_deinit_ptr(cInfo(info));
}

/// Set the active RGFW info/context pointer.
pub fn setInfo(info: *Info) void {
    c.RGFW_setInfo(cInfo(info));
}

/// Get the active RGFW info/context pointer, or null if uninitialized.
pub fn getInfo() ?*Info {
    return zigInfo(c.RGFW_getInfo());
}

/// Returns the size in bytes of the `Info` structure.
pub fn sizeofInfo() usize {
    return c.RGFW_sizeofInfo();
}

/// Returns the size in bytes of the `Window` structure.
pub fn sizeofWindow() usize {
    return c.RGFW_sizeofWindow();
}

/// Returns the size in bytes of the `WindowSrc` structure.
pub fn sizeofWindowSrc() usize {
    return c.RGFW_sizeofWindowSrc();
}

/// Returns true if RGFW is using the Wayland backend, false otherwise.
pub fn usingWayland() bool {
    return boolFromC(c.RGFW_usingWayland());
}

/// Retrieves the current Cocoa layer pointer (macOS only). Returns null on other platforms.
pub fn getLayerOsx() ?*anyopaque {
    return c.RGFW_getLayer_OSX();
}

/// Retrieves the current X11 Display pointer. Returns null if not on X11.
pub fn getDisplayX11() ?*anyopaque {
    return c.RGFW_getDisplay_X11();
}

/// Retrieves the current Wayland display (`wl_display*`) pointer. Returns null if not on Wayland.
pub fn getDisplayWayland() ?*WlDisplay {
    const display = c.RGFW_getDisplay_Wayland();
    return if (display == null) null else ptrCast(*WlDisplay, display);
}

/// (macOS only) Changes the current working directory to the application's resource folder.
pub fn moveToMacOSResourceDir() void {
    c.RGFW_moveToMacOSResourceDir();
}

/// Copy image data from `src` to `dest`, converting pixel formats as needed.
/// If `func` is provided, it is used for the conversion; otherwise a default path is taken.
pub fn copyImageData(dest: []u8, size: Size, dest_format: Format, src: []u8, src_format: Format, func: ConvertImageDataFunc) void {
    c.RGFW_copyImageData(dest.ptr, size.w, size.h, @intFromEnum(dest_format), src.ptr, @intFromEnum(src_format), func);
}

/// 64-bit aware image data copy with format conversion.
/// `is_64_bit` indicates whether the image data uses 64-bit pixels.
pub fn copyImageData64(dest: []u8, size: Size, dest_format: Format, src: []u8, src_format: Format, is_64_bit: bool, func: ConvertImageDataFunc) void {
    c.RGFW_copyImageData64(dest.ptr, size.w, size.h, @intFromEnum(dest_format), src.ptr, @intFromEnum(src_format), boolToC(is_64_bit), func);
}

/// Convert raw pixel data between color layouts (e.g. RGB ↔ BGR).
/// Uses source and destination layout descriptors. `is_64_bit` controls stride.
pub fn convertImageData64(dest: []u8, src: []u8, src_layout: *const ColorLayout, dest_layout: *const ColorLayout, count: usize, is_64_bit: bool) void {
    c.RGFW_convertImageData64(dest.ptr, src.ptr, ptrCast(*const c.RGFW_colorLayout, src_layout), ptrCast(*const c.RGFW_colorLayout, dest_layout), count, boolToC(is_64_bit));
}

/// Returns the size in bytes of the `NativeImage` structure.
pub fn sizeofNativeImage() usize {
    return c.RGFW_sizeofNativeImage();
}

/// Enable or disable raw mouse mode globally.
/// When enabled, unaccelerated mouse deltas are reported via `RGFW_mouseRawMotion` events.
pub fn setRawMouseMode(state: bool) void {
    c.RGFW_setRawMouseMode(boolToC(state));
}

/// Toggle building the drag-and-drop linked list of dropped items.
/// If `true`, dropped data items are stored in a linked list for later retrieval.
pub fn setBuildDnd(allow: bool) void {
    c.RGFW_setBuildDND(boolToC(allow));
}

/// Block until an event is available, or until `wait_ms` milliseconds have elapsed.
/// If `wait_ms` is 0, returns immediately. If `wait_ms` is -1, waits indefinitely for the next event.
pub fn waitForEvent(wait_ms: i32) void {
    c.RGFW_waitForEvent(@intCast(wait_ms));
}

/// Poll all pending events and process them, then reset per-frame input state.
/// Must be called once per frame in the main loop to keep input/events current.
pub fn pollEvents() void {
    c.RGFW_pollEvents();
}

/// Force `waitForEvent` to stop waiting early (used for inter-thread signalling).
pub fn stopCheckEvents() void {
    c.RGFW_stopCheckEvents();
}

/// Enable or disable event queuing. When enabled, events are stored in a FIFO queue.
/// When disabled, only the most recent state is available (immediate mode).
pub fn setQueueEvents(queue: bool) void {
    c.RGFW_setQueueEvents(boolToC(queue));
}

/// Set a callback function for a specific event type.
/// Returns the previously set callback for that type (or null).
pub fn setEventCallback(event_type: EventType, func: GenericFunc) GenericFunc {
    return c.RGFW_setEventCallback(@intCast(event_type), func);
}

/// Set a callback for two sequential event types starting at `event_type`.
/// `first` and `second` receive the previous callbacks for those slots.
pub fn setDualEventCallback(event_type: EventType, func: GenericFunc, first: *GenericFunc, second: *GenericFunc) void {
    c.RGFW_setDualEventCallback(@intCast(event_type), func, first, second);
}

/// Set a single callback for ALL event types. The previous callbacks are stored in `callback_set`.
pub fn setAllEventCallbacks(func: GenericFunc, callback_set: *Callbacks) void {
    c.RGFW_setAllEventCallbacks(func, callback_set);
}

/// Create a new window with the given title, position, size, and flags.
/// Returns a pointer to the new `Window` or null on failure.
pub fn createWindow(name: [:0]const u8, pos: Position, size: Size, flags: WindowFlags) ?*Window {
    return zigWindow(c.RGFW_createWindow(name.ptr, pos.x, pos.y, size.w, size.h, @as(u32, @bitCast(flags))));
}

/// Create a new window using a pre-allocated `Window` structure.
/// Returns the window pointer or null on failure.
pub fn createWindowPtr(name: [:0]const u8, pos: Position, size: Size, flags: WindowFlags, win: *Window) ?*Window {
    return zigWindow(c.RGFW_createWindowPtr(name.ptr, pos.x, pos.y, size.w, size.h, @as(u32, @bitCast(flags)), cWindow(win)));
}

/// Retrieve the global mouse cursor position in screen coordinates.
/// Returns null if the operation failed.
pub fn getGlobalMouse() ?Position {
    var x: i32 = 0;
    var y: i32 = 0;
    if (!boolFromC(c.RGFW_getGlobalMouse(&x, &y))) return null;
    return .{ .x = x, .y = y };
}

/// Get the accumulated mouse scroll delta since the last frame.
pub fn getMouseScroll() MouseVector {
    var x: f32 = 0;
    var y: f32 = 0;
    c.RGFW_getMouseScroll(&x, &y);
    return .{ .x = x, .y = y };
}

/// Get the raw mouse motion vector since the last frame.
pub fn getMouseVector() MouseVector {
    var x: f32 = 0;
    var y: f32 = 0;
    c.RGFW_getMouseVector(&x, &y);
    return .{ .x = x, .y = y };
}

/// Returns true if the key was pressed this frame (transition from up to down).
pub fn isKeyPressed(key_code: Key) bool {
    return boolFromC(c.RGFW_isKeyPressed(@intFromEnum(key_code)));
}

/// Returns true if the key was released this frame (transition from down to up).
pub fn isKeyReleased(key_code: Key) bool {
    return boolFromC(c.RGFW_isKeyReleased(@intFromEnum(key_code)));
}

/// Returns true if the key is currently held down.
pub fn isKeyDown(key_code: Key) bool {
    return boolFromC(c.RGFW_isKeyDown(@intFromEnum(key_code)));
}

/// Returns true if the mouse button was pressed this frame.
pub fn isMousePressed(button: MouseButton) bool {
    return boolFromC(c.RGFW_isMousePressed(@intFromEnum(button)));
}

/// Returns true if the mouse button was released this frame.
pub fn isMouseReleased(button: MouseButton) bool {
    return boolFromC(c.RGFW_isMouseReleased(@intFromEnum(button)));
}

/// Returns true if the mouse button is currently held down.
pub fn isMouseDown(button: MouseButton) bool {
    return boolFromC(c.RGFW_isMouseDown(@intFromEnum(button)));
}

/// Set the root (main) window for the current RGFW context.
pub fn setRootWindow(win: ?*Window) void {
    c.RGFW_setRootWindow(if (win) |w| cWindow(w) else null);
}

/// Get the current root window, or null if none is set.
pub fn getRootWindow() ?*Window {
    return zigWindow(c.RGFW_getRootWindow());
}

/// Convert a platform-specific keycode to an RGFW abstract key code.
pub fn apiKeyToRgfw(keycode: u32) Key {
    return @intCast(c.RGFW_apiKeyToRGFW(@intFromEnum(keycode)));
}

/// Convert an RGFW abstract key code to a platform-specific keycode.
pub fn rgfwToApiKey(keycode: Key) u32 {
    return @intCast(c.RGFW_rgfwToApiKey(@intFromEnum(keycode)));
}

/// Convert a physical RGFW key code to a mapped (character) RGFW key code,
/// taking keyboard layout into account.
pub fn physicalToMappedKey(keycode: Key) Key {
    return @intCast(c.RGFW_physicalToMappedKey(@intFromEnum(keycode)));
}

/// Check if a string contains any non-ASCII characters (>= 0x80).
pub fn isLatin(text: []const u8) bool {
    return boolFromC(c.RGFW_isLatin(text.ptr, text.len));
}

/// Decode a single UTF-8 codepoint from `text` starting at `starting_index`.
/// Advances `starting_index` past the decoded sequence.
pub fn decodeUtf8(text: [:0]const u8, starting_index: *usize) u32 {
    return @intCast(c.RGFW_decodeUTF8(text.ptr, starting_index));
}

/// Check if a specific OpenGL extension string is present in the given extension list.
/// Uses string matching (not the OpenGL API directly).
pub fn extensionSupportedStr(extensions: [:0]const u8, extension: []const u8) bool {
    return boolFromC(c.RGFW_extensionSupportedStr(extensions.ptr, extension.ptr, extension.len));
}

/// Check if an OpenGL extension is supported using a custom procedure loader.
pub fn extensionSupportedBase(extension: []const u8, get_proc_address: ProcLoader) bool {
    return boolFromC(c.RGFW_extensionSupported_base(extension.ptr, extension.len, @ptrCast(get_proc_address)));
}

/// Window management and query functions.
pub const window = struct {
    /// Create a software surface for the given window from raw pixel data.
    pub fn createSurface(win: *Window, image: Image) ?*Surface {
        return zigSurface(c.RGFW_window_createSurface(cWindow(win), image.data.ptr, image.w, image.h, @intCast(image.format)));
    }

    /// Create a software surface using a pre-allocated `Surface` structure.
    pub fn createSurfacePtr(win: *Window, image: Image, surface_ptr: *Surface) bool {
        return boolFromC(c.RGFW_window_createSurfacePtr(cWindow(win), image.data.ptr, image.w, image.h, @intCast(image.format), cSurface(surface_ptr)));
    }

    /// Close the window and free its associated structure.
    pub fn close(win: *Window) void {
        c.RGFW_window_close(cWindow(win));
    }

    /// Close the window without freeing its structure (for pre-allocated windows).
    pub fn closePtr(win: *Window) void {
        c.RGFW_window_closePtr(cWindow(win));
    }

    /// Check if the window should close (e.g. ESC was pressed or close button clicked).
    pub fn shouldClose(win: *Window) bool {
        return boolFromC(c.RGFW_window_shouldClose(cWindow(win)));
    }

    /// Explicitly set or clear the "should close" state of the window.
    pub fn setShouldClose(win: *Window, should_close: bool) void {
        c.RGFW_window_setShouldClose(cWindow(win), boolToC(should_close));
    }

    /// Get the exit key assigned to the window (e.g. ESC).
    pub fn getExitKey(win: *Window) Key {
        return @intCast(c.RGFW_window_getExitKey(cWindow(win)));
    }

    /// Set the exit key for the window. When this key is pressed, `shouldClose` returns true.
    pub fn setExitKey(win: *Window, key_code: Key) void {
        c.RGFW_window_setExitKey(cWindow(win), @intFromEnum(key_code));
    }

    /// Get the window position in screen coordinates.
    pub fn getPosition(win: *Window) ?Position {
        var x: i32 = 0;
        var y: i32 = 0;
        if (!boolFromC(c.RGFW_window_getPosition(cWindow(win), &x, &y))) return null;
        return .{ .x = x, .y = y };
    }

    /// Get the window client area size.
    pub fn getSize(win: *Window) ?Size {
        var w: i32 = 0;
        var h: i32 = 0;
        if (!boolFromC(c.RGFW_window_getSize(cWindow(win), &w, &h))) return null;
        return .{ .w = w, .h = h };
    }

    /// Get the window size in physical pixels, accounting for DPI scaling.
    pub fn getSizeInPixels(win: *Window) ?Size {
        var w: i32 = 0;
        var h: i32 = 0;
        if (!boolFromC(c.RGFW_window_getSizeInPixels(cWindow(win), &w, &h))) return null;
        return .{ .w = w, .h = h };
    }

    /// Fetch the current window size directly from the operating system.
    pub fn fetchSize(win: *Window) ?Size {
        var w: i32 = 0;
        var h: i32 = 0;
        if (!boolFromC(c.RGFW_window_fetchSize(cWindow(win), &w, &h))) return null;
        return .{ .w = w, .h = h };
    }

    /// Get the current window flags bitmask.
    pub fn getFlags(win: *Window) WindowFlags {
        return @intCast(c.RGFW_window_getFlags(cWindow(win)));
    }

    /// Set the window flags (will apply or undo flag effects as needed).
    pub fn setFlags(win: *Window, flags: WindowFlags) void {
        c.RGFW_window_setFlags(cWindow(win), @as(u32, @bitCast(flags)));
    }

    /// Set which event types are enabled for this window.
    pub fn setEnabledEvents(win: *Window, events: EventFlag) void {
        c.RGFW_window_setEnabledEvents(cWindow(win), @intCast(events));
    }

    /// Get the bitmask of currently enabled event types for this window.
    pub fn getEnabledEvents(win: *Window) EventFlag {
        return @intCast(c.RGFW_window_getEnabledEvents(cWindow(win)));
    }

    /// Enable all events except those specified in `events`.
    pub fn setDisabledEvents(win: *Window, events: EventFlag) void {
        c.RGFW_window_setDisabledEvents(cWindow(win), @intCast(events));
    }

    /// Directly set the enabled/disabled state of a specific event type.
    pub fn setEventState(win: *Window, event: EventFlag, state: bool) void {
        c.RGFW_window_setEventState(cWindow(win), @intCast(event), boolToC(state));
    }

    /// Get the user-defined pointer associated with the window.
    pub fn getUserPtr(win: *Window) ?*anyopaque {
        return c.RGFW_window_getUserPtr(cWindow(win));
    }

    /// Set a user-defined pointer to associate with the window.
    pub fn setUserPtr(win: *Window, ptr: ?*anyopaque) void {
        c.RGFW_window_setUserPtr(cWindow(win), ptr);
    }

    /// Retrieve the platform-specific window source pointer (e.g. HWND, Window, NSView).
    pub fn getSrc(win: *Window) ?*WindowSrc {
        const src = c.RGFW_window_getSrc(cWindow(win));
        return if (src == null) null else ptrCast(*WindowSrc, src);
    }

    /// Set the macOS CALayer for the window (macOS only).
    pub fn setLayerOsx(win: *Window, layer: ?*anyopaque) void {
        c.RGFW_window_setLayer_OSX(cWindow(win), layer);
    }

    /// Get the macOS NSView for the window (macOS only).
    pub fn getViewOsx(win: *Window) ?*anyopaque {
        return c.RGFW_window_getView_OSX(cWindow(win));
    }

    /// Get the macOS NSWindow for the window (macOS only).
    pub fn getWindowOsx(win: *Window) ?*anyopaque {
        return c.RGFW_window_getWindow_OSX(cWindow(win));
    }

    /// Get the Windows HWND handle (Windows only).
    pub fn getHwnd(win: *Window) ?*anyopaque {
        return c.RGFW_window_getHWND(cWindow(win));
    }

    /// Get the Windows HDC (device context) handle (Windows only).
    pub fn getHdc(win: *Window) ?*anyopaque {
        return c.RGFW_window_getHDC(cWindow(win));
    }

    /// Get the X11 Window ID (X11 only).
    pub fn getWindowX11(win: *Window) u64 {
        return @intCast(c.RGFW_window_getWindow_X11(cWindow(win)));
    }

    /// Get the Wayland `wl_surface*` for the window (Wayland only).
    pub fn getWindowWayland(win: *Window) ?*WlSurface {
        const surface_ptr = c.RGFW_window_getWindow_Wayland(cWindow(win));
        return if (surface_ptr == null) null else ptrCast(*WlSurface, surface_ptr);
    }

    /// Poll and pop the next event for this specific window.
    pub fn checkEvent(win: *Window, event: *Event) bool {
        return boolFromC(c.RGFW_window_checkEvent(cWindow(win), ptrCast(*c.RGFW_event, event)));
    }

    /// Pop the first queued event for this specific window without polling.
    pub fn checkQueuedEvent(win: *Window, event: *Event) bool {
        return boolFromC(c.RGFW_window_checkQueuedEvent(cWindow(win), ptrCast(*c.RGFW_event, event)));
    }

    /// Returns true if the key was pressed this frame while the window is in focus.
    pub fn isKeyPressed(win: *Window, key_code: Key) bool {
        return boolFromC(c.RGFW_window_isKeyPressed(cWindow(win), @intFromEnum(key_code)));
    }

    /// Returns true if the key is being held down while the window is in focus.
    pub fn isKeyDown(win: *Window, key_code: Key) bool {
        return boolFromC(c.RGFW_window_isKeyDown(cWindow(win), @intFromEnum(key_code)));
    }

    /// Returns true if the key was released this frame while the window is in focus.
    pub fn isKeyReleased(win: *Window, key_code: Key) bool {
        return boolFromC(c.RGFW_window_isKeyReleased(cWindow(win), @intFromEnum(key_code)));
    }

    /// Returns true if the mouse button was pressed this frame while the window is in focus.
    pub fn isMousePressed(win: *Window, button: MouseButton) bool {
        return boolFromC(c.RGFW_window_isMousePressed(cWindow(win), @intFromEnum(button)));
    }

    /// Returns true if the mouse button is held down while the window is in focus.
    pub fn isMouseDown(win: *Window, button: MouseButton) bool {
        return boolFromC(c.RGFW_window_isMouseDown(cWindow(win), @intFromEnum(button)));
    }

    /// Returns true if the mouse button was released this frame while the window is in focus.
    pub fn isMouseReleased(win: *Window, button: MouseButton) bool {
        return boolFromC(c.RGFW_window_isMouseReleased(cWindow(win), @intFromEnum(button)));
    }

    /// Returns true if the mouse left the window (only true for the first frame).
    pub fn didMouseLeave(win: *Window) bool {
        return boolFromC(c.RGFW_window_didMouseLeave(cWindow(win)));
    }

    /// Returns true if the mouse entered the window (only true for the first frame).
    pub fn didMouseEnter(win: *Window) bool {
        return boolFromC(c.RGFW_window_didMouseEnter(cWindow(win)));
    }

    /// Returns true if the mouse is currently inside the window bounds.
    pub fn isMouseInside(win: *Window) bool {
        return boolFromC(c.RGFW_window_isMouseInside(cWindow(win)));
    }

    /// Returns true if data is currently being dragged into or within the window.
    pub fn isDataDragging(win: *Window) bool {
        return boolFromC(c.RGFW_window_isDataDragging(cWindow(win)));
    }

    /// Get the position of an active drag operation, or null if none.
    pub fn getDataDrag(win: *Window) ?Position {
        var x: i32 = 0;
        var y: i32 = 0;
        if (!boolFromC(c.RGFW_window_getDataDrag(cWindow(win), &x, &y))) return null;
        return .{ .x = x, .y = y };
    }

    /// Returns true if data was dropped into the window this frame (first frame only).
    pub fn didDataDrop(win: *Window) bool {
        return boolFromC(c.RGFW_window_didDataDrop(cWindow(win)));
    }

    /// Get the linked list of dropped data items, or null if no drop occurred.
    pub fn getDataDrop(win: *Window) ?*DataDropNode {
        const node = c.RGFW_window_getDataDrop(cWindow(win));
        return if (node == null) null else ptrCast(*DataDropNode, node);
    }

    /// Move the window to a new position on the screen.
    pub fn move(win: *Window, pos: Position) void {
        c.RGFW_window_move(cWindow(win), pos.x, pos.y);
    }

    /// Resize the window to the given dimensions.
    pub fn resize(win: *Window, size: Size) void {
        c.RGFW_window_resize(cWindow(win), size.w, size.h);
    }

    /// Move the window to a specific monitor.
    pub fn moveToMonitor(win: *Window, mon: *Monitor) void {
        c.RGFW_window_moveToMonitor(cWindow(win), cMonitor(mon));
    }

    /// Set the window's aspect ratio (width:height).
    pub fn setAspectRatio(win: *Window, size: Size) void {
        c.RGFW_window_setAspectRatio(cWindow(win), size.w, size.h);
    }

    /// Set the minimum window size.
    pub fn setMinSize(win: *Window, size: Size) void {
        c.RGFW_window_setMinSize(cWindow(win), size.w, size.h);
    }

    /// Set the maximum window size.
    pub fn setMaxSize(win: *Window, size: Size) void {
        c.RGFW_window_setMaxSize(cWindow(win), size.w, size.h);
    }

    /// Set input focus to the window.
    pub fn focus(win: *Window) void {
        c.RGFW_window_focus(cWindow(win));
    }

    /// Check if the window currently has keyboard focus.
    pub fn isInFocus(win: *Window) bool {
        return boolFromC(c.RGFW_window_isInFocus(cWindow(win)));
    }

    /// Raise the window to the top of the window stack.
    pub fn raise(win: *Window) void {
        c.RGFW_window_raise(cWindow(win));
    }

    /// Maximize the window to fill the screen.
    pub fn maximize(win: *Window) void {
        c.RGFW_window_maximize(cWindow(win));
    }

    /// Center the window on its current monitor.
    pub fn center(win: *Window) void {
        c.RGFW_window_center(cWindow(win));
    }

    /// Minimize the window to the taskbar/dock.
    pub fn minimize(win: *Window) void {
        c.RGFW_window_minimize(cWindow(win));
    }

    /// Restore the window from minimized or maximized state.
    pub fn restore(win: *Window) void {
        c.RGFW_window_restore(cWindow(win));
    }

    /// Hide the window from view.
    pub fn hide(win: *Window) void {
        c.RGFW_window_hide(cWindow(win));
    }

    /// Show the window if it was hidden.
    pub fn show(win: *Window) void {
        c.RGFW_window_show(cWindow(win));
    }

    /// Request a window flash to grab the user's attention.
    pub fn flash(win: *Window, request: FlashRequest) void {
        c.RGFW_window_flash(cWindow(win), @intCast(request));
    }

    /// Toggle fullscreen mode for the window.
    pub fn setFullscreen(win: *Window, fullscreen: bool) void {
        c.RGFW_window_setFullscreen(cWindow(win), boolToC(fullscreen));
    }

    /// Make the window floating (always-on-top) or not.
    pub fn setFloating(win: *Window, floating: bool) void {
        c.RGFW_window_setFloating(cWindow(win), boolToC(floating));
    }

    /// Set the window opacity level (0–255). 0 = fully transparent, 255 = fully opaque.
    pub fn setOpacity(win: *Window, opacity: u8) void {
        c.RGFW_window_setOpacity(cWindow(win), opacity);
    }

    /// Show or hide the window border/frame/decorations.
    pub fn setBorder(win: *Window, border: bool) void {
        c.RGFW_window_setBorder(cWindow(win), boolToC(border));
    }

    /// Check if the window is borderless (no frame/decorations).
    pub fn borderless(win: *Window) bool {
        return boolFromC(c.RGFW_window_borderless(cWindow(win)));
    }

    /// Enable or disable drag-and-drop support for the window.
    /// Note: `windowFlag.allowDnd` must still be set at window creation.
    pub fn setDnd(win: *Window, allow: bool) void {
        c.RGFW_window_setDND(cWindow(win), boolToC(allow));
    }

    /// Check if drag-and-drop is enabled for the window.
    pub fn allowsDnd(win: *Window) bool {
        return boolFromC(c.RGFW_window_allowsDND(cWindow(win)));
    }

    /// Toggle mouse passthrough for the window (clicks pass through to windows behind).
    /// Requires RGFW to be compiled without `RGFW_NO_PASSTHROUGH`.
    pub fn setMousePassthrough(win: *Window, passthrough: bool) void {
        c.RGFW_window_setMousePassthrough(cWindow(win), boolToC(passthrough));
    }

    /// Set the window title.
    pub fn setName(win: *Window, name: [:0]const u8) void {
        c.RGFW_window_setName(cWindow(win), name.ptr);
    }

    /// Set the window icon and taskbar icon from image data.
    pub fn setIcon(win: *Window, image: Image) bool {
        return boolFromC(c.RGFW_window_setIcon(cWindow(win), image.data.ptr, image.w, image.h, @intCast(image.format)));
    }

    /// Set the window and/or taskbar icon with explicit target selection.
    pub fn setIconEx(win: *Window, image: Image, icon_type: Icon) bool {
        return boolFromC(c.RGFW_window_setIconEx(cWindow(win), image.data.ptr, image.w, image.h, @intCast(image.format), @intCast(icon_type)));
    }

    /// Show or hide the mouse cursor over the window.
    pub fn showMouse(win: *Window, visible: bool) void {
        c.RGFW_window_showMouse(cWindow(win), boolToC(visible));
    }

    /// Check if the mouse cursor is hidden over the window.
    pub fn isMouseHidden(win: *Window) bool {
        return boolFromC(c.RGFW_window_isMouseHidden(cWindow(win)));
    }

    /// Move the mouse cursor to a position within the window.
    pub fn moveMouse(win: *Window, pos: Position) void {
        c.RGFW_window_moveMouse(cWindow(win), pos.x, pos.y);
    }

    /// Get the current mouse position relative to the window's client area.
    pub fn getMouse(win: *Window) ?Position {
        var x: i32 = 0;
        var y: i32 = 0;
        if (!boolFromC(c.RGFW_window_getMouse(cWindow(win), &x, &y))) return null;
        return .{ .x = x, .y = y };
    }

    /// Check if the window is currently fullscreen.
    pub fn isFullscreen(win: *Window) bool {
        return boolFromC(c.RGFW_window_isFullscreen(cWindow(win)));
    }

    /// Check if the window is currently hidden.
    pub fn isHidden(win: *Window) bool {
        return boolFromC(c.RGFW_window_isHidden(cWindow(win)));
    }

    /// Check if the window is currently minimized.
    pub fn isMinimized(win: *Window) bool {
        return boolFromC(c.RGFW_window_isMinimized(cWindow(win)));
    }

    /// Check if the window is currently maximized.
    pub fn isMaximized(win: *Window) bool {
        return boolFromC(c.RGFW_window_isMaximized(cWindow(win)));
    }

    /// Check if the window is floating (always-on-top).
    pub fn isFloating(win: *Window) bool {
        return boolFromC(c.RGFW_window_isFloating(cWindow(win)));
    }

    /// Scale the window to match its monitor's DPI/content scale.
    pub fn scaleToMonitor(win: *Window) void {
        c.RGFW_window_scaleToMonitor(cWindow(win));
    }

    /// Get the monitor that the window is currently on.
    pub fn getMonitor(win: *Window) ?*Monitor {
        return zigMonitor(c.RGFW_window_getMonitor(cWindow(win)));
    }
};

/// Monitor enumeration and management functions.
pub const monitor = struct {
    /// Poll and refresh the list of connected monitors.
    pub fn poll() void {
        c.RGFW_pollMonitors();
    }

    /// Free all monitor data (called internally during deinit).
    pub fn freeAll() void {
        c.RGFW_freeMonitors();
    }

    /// Get the primary monitor.
    pub fn getPrimary() ?*Monitor {
        return zigMonitor(c.RGFW_getPrimaryMonitor());
    }

    /// Get an allocated array of all available monitors. Must be freed with `free`.
    pub fn getMonitors() ?[]?*Monitor {
        var len: usize = 0;
        const monitors = c.RGFW_getMonitors(&len);
        if (monitors == null) return null;
        return @as([*]?*Monitor, @ptrCast(monitors))[0..len];
    }

    /// Fill a pre-allocated buffer of monitor pointers. Returns the number of monitors written.
    pub fn getAll(buffer: []?*Monitor) usize {
        var len: usize = 0;
        const ok = c.RGFW_getMonitorsPtr(buffer.len, @ptrCast(buffer.ptr), &len);
        if (!boolFromC(ok)) return 0;
        return len;
    }

    /// Get an allocated array of supported display modes for a monitor.
    pub fn getModes(mon: *Monitor) ?[]MonitorMode {
        var count: usize = 0;
        const modes = c.RGFW_monitor_getModes(cMonitor(mon), &count);
        if (modes == null) return null;
        return @as([*]MonitorMode, @ptrCast(modes))[0..count];
    }

    /// Get the supported modes of a monitor using a pre-allocated pointer.
    pub fn getModesPtr(mon: *Monitor) ?[]MonitorMode {
        var modes: [*c]c.RGFW_monitorMode = null;
        const count = c.RGFW_monitor_getModesPtr(cMonitor(mon), &modes);
        if (modes == null) return null;
        return @as([*]MonitorMode, @ptrCast(modes))[0..count];
    }

    /// Free an array of monitor modes previously returned by `getModes`.
    pub fn freeModes(modes: []MonitorMode) void {
        c.RGFW_freeModes(@ptrCast(modes.ptr));
    }

    /// Find the closest matching mode for a monitor based on size (highest priority),
    /// then format, then refresh rate.
    pub fn findClosestMode(mon: *Monitor, mode: *MonitorMode) ?MonitorMode {
        var closest: c.RGFW_monitorMode = undefined;
        if (!boolFromC(c.RGFW_monitor_findClosestMode(cMonitor(mon), ptrCast(*c.RGFW_monitorMode, mode), &closest))) return null;
        return @bitCast(closest);
    }

    /// Get an allocated gamma ramp for a monitor.
    pub fn getGammaRamp(mon: *Monitor) ?*GammaRamp {
        const ramp = c.RGFW_monitor_getGammaRamp(cMonitor(mon));
        return if (ramp == null) null else ptrCast(*GammaRamp, ramp);
    }

    /// Free a gamma ramp allocated by `getGammaRamp`.
    pub fn freeGammaRamp(ramp: *GammaRamp) void {
        c.RGFW_freeGammaRamp(ptrCast(*c.RGFW_gammaRamp, ramp));
    }

    /// Get a monitor's gamma ramp using a pre-allocated structure.
    pub fn getGammaRampPtr(mon: *Monitor, ramp: *GammaRamp) usize {
        return c.RGFW_monitor_getGammaRampPtr(cMonitor(mon), ptrCast(*c.RGFW_gammaRamp, ramp));
    }

    /// Set a monitor's gamma ramp from a pre-allocated structure.
    pub fn setGammaRamp(mon: *Monitor, ramp: *GammaRamp) bool {
        return boolFromC(c.RGFW_monitor_setGammaRamp(cMonitor(mon), ptrCast(*c.RGFW_gammaRamp, ramp)));
    }

    /// Set a monitor's gamma with a base gamma exponent (allocates internally).
    pub fn setGamma(mon: *Monitor, gamma: f32) bool {
        return boolFromC(c.RGFW_monitor_setGamma(cMonitor(mon), gamma));
    }

    /// Set a monitor's gamma using a pre-allocated channel array.
    pub fn setGammaPtr(mon: *Monitor, gamma: f32, ptr: []u16) bool {
        return boolFromC(c.RGFW_monitor_setGammaPtr(cMonitor(mon), gamma, ptr.ptr, ptr.len));
    }

    /// Get the position of a monitor.
    pub fn getPosition(mon: *Monitor) ?Position {
        var x: i32 = 0;
        var y: i32 = 0;
        if (!boolFromC(c.RGFW_monitor_getPosition(cMonitor(mon), &x, &y))) return null;
        return .{ .x = x, .y = y };
    }

    /// Get the workarea of a monitor (excluding OS UI elements like the taskbar).
    pub fn getWorkarea(mon: *Monitor) ?Rect {
        var x: i32 = 0;
        var y: i32 = 0;
        var w: i32 = 0;
        var h: i32 = 0;
        if (!boolFromC(c.RGFW_monitor_getWorkarea(cMonitor(mon), &x, &y, &w, &h))) return null;
        return .{ .x = x, .y = y, .w = w, .h = h };
    }

    /// Get the name of a monitor.
    pub fn getName(mon: *Monitor) ?[*:0]const u8 {
        const name = c.RGFW_monitor_getName(cMonitor(mon));
        return if (name == null) null else @ptrCast(name);
    }

    /// Get the content scale of a monitor (DPI scaling factor).
    pub fn getScale(mon: *Monitor) ?Scale {
        var x: f32 = 0;
        var y: f32 = 0;
        if (!boolFromC(c.RGFW_monitor_getScale(cMonitor(mon), &x, &y))) return null;
        return .{ .x = x, .y = y };
    }

    /// Get the physical size of a monitor in inches.
    pub fn getPhysicalSize(mon: *Monitor) ?Scale {
        var w: f32 = 0;
        var h: f32 = 0;
        if (!boolFromC(c.RGFW_monitor_getPhysicalSize(cMonitor(mon), &w, &h))) return null;
        return .{ .x = w, .y = h };
    }

    /// Set a user pointer on a monitor.
    pub fn setUserPtr(mon: *Monitor, user_ptr: ?*anyopaque) void {
        c.RGFW_monitor_setUserPtr(cMonitor(mon), user_ptr);
    }

    /// Get the user pointer from a monitor.
    pub fn getUserPtr(mon: *Monitor) ?*anyopaque {
        return c.RGFW_monitor_getUserPtr(cMonitor(mon));
    }

    /// Get the current display mode of a monitor.
    pub fn getMode(mon: *Monitor) ?MonitorMode {
        var mode: c.RGFW_monitorMode = undefined;
        if (!boolFromC(c.RGFW_monitor_getMode(cMonitor(mon), &mode))) return null;
        return @bitCast(mode);
    }

    /// Request a specific display mode for a monitor (selects closest match).
    pub fn requestMode(mon: *Monitor, mode: *MonitorMode, request: ModeRequest) bool {
        return boolFromC(c.RGFW_monitor_requestMode(cMonitor(mon), ptrCast(*c.RGFW_monitorMode, mode), @intCast(request)));
    }

    /// Directly set a specific display mode for a monitor.
    pub fn setMode(mon: *Monitor, mode: *MonitorMode) bool {
        return boolFromC(c.RGFW_monitor_setMode(cMonitor(mon), ptrCast(*c.RGFW_monitorMode, mode)));
    }

    /// Compare two monitor modes for equivalence under the given `request` flags.
    pub fn modeCompare(a: *MonitorMode, b: *MonitorMode, request: ModeRequest) bool {
        return boolFromC(c.RGFW_monitorModeCompare(ptrCast(*c.RGFW_monitorMode, a), ptrCast(*c.RGFW_monitorMode, b), @intCast(request)));
    }

    /// Scale a monitor's mode to match a window's size.
    pub fn scaleToWindow(mon: *Monitor, win: *Window) bool {
        return boolFromC(c.RGFW_monitor_scaleToWindow(cMonitor(mon), cWindow(win)));
    }
};

/// Software surface creation, manipulation, and blitting.
pub const surface = struct {
    /// Create a new software surface from raw pixel data.
    pub fn create(image: Image) ?*Surface {
        return zigSurface(c.RGFW_createSurface(image.data.ptr, image.w, image.h, @intCast(image.format)));
    }

    /// Create a software surface using a pre-allocated `Surface` structure.
    pub fn createPtr(image: Image, surface_ptr: *Surface) bool {
        return boolFromC(c.RGFW_createSurfacePtr(image.data.ptr, image.w, image.h, @intCast(image.format), cSurface(surface_ptr)));
    }

    /// Get the native image associated with a surface.
    pub fn getNativeImage(surface_ptr: *Surface) ?*NativeImage {
        const image = c.RGFW_surface_getNativeImage(cSurface(surface_ptr));
        return if (image == null) null else ptrCast(*NativeImage, image);
    }

    /// Set a custom format conversion function for the surface.
    /// If null, the default conversion path is used.
    pub fn setConvertFunc(surface_ptr: *Surface, func: ConvertImageDataFunc) void {
        c.RGFW_surface_setConvertFunc(cSurface(surface_ptr), func);
    }

    /// Free the surface and all associated buffers.
    pub fn free(surface_ptr: *Surface) void {
        c.RGFW_surface_free(cSurface(surface_ptr));
    }

    /// Free only the internal buffers of a surface, leaving the struct intact.
    pub fn freePtr(surface_ptr: *Surface) void {
        c.RGFW_surface_freePtr(cSurface(surface_ptr));
    }

    /// Returns the size in bytes of the `Surface` structure.
    pub fn sizeof() usize {
        return c.RGFW_sizeofSurface();
    }

    /// Returns the native pixel format for the current platform.
    pub fn nativeFormat() Format {
        return @intCast(c.RGFW_nativeFormat());
    }

    /// Blit a surface to a window for display.
    pub fn blit(win: *Window, surface_ptr: *Surface) void {
        c.RGFW_window_blitSurface(cWindow(win), cSurface(surface_ptr));
    }
};

/// Event queue push, pop, and flush operations.
pub const eventQueue = struct {
    /// Push an event into the standard RGFW event queue.
    pub fn push(event: *const Event) void {
        c.RGFW_eventQueuePush(ptrCast(*const c.RGFW_event, event));
    }

    /// Push an event into the queue and immediately call its callback (if set).
    pub fn pushAndCall(event: *const Event) void {
        c.RGFW_eventQueuePushAndCall(ptrCast(*const c.RGFW_event, event));
    }

    /// Clear all events from the queue without processing them.
    pub fn flush() void {
        c.RGFW_eventQueueFlush();
    }

    /// Pop the next event from the queue, or null if empty.
    pub fn pop() ?*Event {
        const event = c.RGFW_eventQueuePop();
        return if (event == null) null else ptrCast(*Event, event);
    }

    /// Pop the next event that belongs to the given window. Events for other
    /// windows are pushed back into the queue.
    pub fn popWindow(win: *Window) ?*Event {
        const event = c.RGFW_window_eventQueuePop(cWindow(win));
        return if (event == null) null else ptrCast(*Event, event);
    }
};

/// Debug message callback and dispatch.
pub const debug = struct {
    /// Set a callback to receive debug messages from RGFW.
    /// Returns the previously set callback.
    pub fn setCallback(func: DebugFunc) DebugFunc {
        return c.RGFW_setDebugCallback(func);
    }

    /// Manually send a debug message through the currently set callback.
    pub fn callback(debug_type: DebugType, code: ErrorCode, msg: [:0]const u8) void {
        c.RGFW_debugCallback(@intCast(debug_type), @intCast(code), msg.ptr);
    }
};

/// Mouse cursor creation and window cursor management.
pub const mouse = struct {
    /// Create a custom mouse cursor from image data.
    pub fn create(image: Image) ?*Mouse {
        return zigMouse(c.RGFW_createMouse(image.data.ptr, image.w, image.h, @intCast(image.format)));
    }

    /// Create a standard system cursor by its icon identifier.
    pub fn createStandard(icon_id: MouseIcon) ?*Mouse {
        return zigMouse(c.RGFW_createMouseStandard(@intCast(icon_id)));
    }

    /// Free a mouse cursor created with `create` or `createStandard`.
    pub fn free(mouse_ptr: *Mouse) void {
        c.RGFW_freeMouse(cMouse(mouse_ptr));
    }

    /// Set a custom mouse cursor for a window.
    pub fn set(win: *Window, mouse_ptr: *Mouse) bool {
        return boolFromC(c.RGFW_window_setMouse(cWindow(win), cMouse(mouse_ptr)));
    }

    /// Set a standard system cursor for a window.
    pub fn setStandard(win: *Window, icon_id: MouseIcon) bool {
        return boolFromC(c.RGFW_window_setMouseStandard(cWindow(win), @intCast(icon_id)));
    }

    /// Reset the window's cursor to the default system cursor.
    pub fn setDefault(win: *Window) bool {
        return boolFromC(c.RGFW_window_setMouseDefault(cWindow(win)));
    }

    /// Enable or disable raw (unaccelerated) mouse mode for a specific window.
    pub fn setRawMode(win: *Window, state: bool) void {
        c.RGFW_window_setRawMouseMode(cWindow(win), boolToC(state));
    }

    /// Capture or release the mouse cursor for a window (cursor is confined to the window).
    pub fn capture(win: *Window, state: bool) void {
        c.RGFW_window_captureMouse(cWindow(win), boolToC(state));
    }

    /// Convenience: capture the mouse AND enable raw mouse mode.
    pub fn captureRaw(win: *Window, state: bool) void {
        c.RGFW_window_captureRawMouse(cWindow(win), boolToC(state));
    }

    /// Check if raw mouse mode is enabled for the window.
    pub fn isRawMode(win: *Window) bool {
        return boolFromC(c.RGFW_window_isRawMouseMode(cWindow(win)));
    }

    /// Check if the mouse is captured (confined to the window).
    pub fn isCaptured(win: *Window) bool {
        return boolFromC(c.RGFW_window_isCaptured(cWindow(win)));
    }
};

/// Clipboard read and write operations.
pub const clipboard = struct {
    /// Read data from the clipboard (allocates internally).
    /// Returns a pointer to the transfer data, or null on failure.
    pub fn read() ?*const DataTransfer {
        const data = c.RGFW_readClipboard();
        return if (data == null) null else ptrCast(*const DataTransfer, data);
    }

    /// Read clipboard data into a user-provided buffer.
    /// `buffer` is the destination, `data` receives the metadata (length, type).
    pub fn readPtr(buffer: []u8, data: *DataTransfer) bool {
        return boolFromC(c.RGFW_readClipboardPtr(buffer.ptr, buffer.len, ptrCast(*c.RGFW_dataTransfer, data)));
    }

    /// Write data to the clipboard.
    pub fn write(data: *const DataTransfer) bool {
        return boolFromC(c.RGFW_writeClipboard(ptrCast(*const c.RGFW_dataTransfer, data)));
    }
};

/// Native OpenGL context creation and management (not EGL).
/// Requires RGFW to be compiled with `RGFW_OPENGL` (enabled by default).
pub const opengl = struct {
    /// Set the global OpenGL hints used for context creation.
    pub fn setGlobalHints(hints: *GlHints) void {
        c.RGFW_setGlobalHints_OpenGL(ptrCast(*c.RGFW_glHints, hints));
    }

    /// Reset the global OpenGL hints to their default values.
    pub fn resetGlobalHints() void {
        c.RGFW_resetGlobalHints_OpenGL();
    }

    /// Get a pointer to the current global OpenGL hints.
    pub fn getGlobalHints() ?*GlHints {
        const hints = c.RGFW_getGlobalHints_OpenGL();
        return if (hints == null) null else ptrCast(*GlHints, hints);
    }

    /// Create and allocate a new native OpenGL context for a window.
    pub fn createContext(win: *Window, hints: ?*GlHints) ?*GlContext {
        const ctx = c.RGFW_window_createContext_OpenGL(cWindow(win), if (hints) |h| ptrCast(*c.RGFW_glHints, h) else null);
        return zigGlContext(ctx);
    }

    /// Create a native OpenGL context using a pre-allocated `GlContext` structure.
    pub fn createContextPtr(win: *Window, ctx: *GlContext, hints: ?*GlHints) bool {
        return boolFromC(c.RGFW_window_createContextPtr_OpenGL(cWindow(win), cGlContext(ctx), if (hints) |h| ptrCast(*c.RGFW_glHints, h) else null));
    }

    /// Get the native OpenGL context associated with a window.
    pub fn getContext(win: *Window) ?*GlContext {
        return zigGlContext(c.RGFW_window_getContext_OpenGL(cWindow(win)));
    }

    /// Delete and free a native OpenGL context.
    pub fn deleteContext(win: *Window, ctx: *GlContext) void {
        c.RGFW_window_deleteContext_OpenGL(cWindow(win), cGlContext(ctx));
    }

    /// Delete a native OpenGL context without freeing its memory.
    pub fn deleteContextPtr(win: *Window, ctx: *GlContext) void {
        c.RGFW_window_deleteContextPtr_OpenGL(cWindow(win), cGlContext(ctx));
    }

    /// Get the underlying native OpenGL context handle from a `GlContext`.
    pub fn contextGetSourceContext(ctx: *GlContext) ?*anyopaque {
        return c.RGFW_glContext_getSourceContext(cGlContext(ctx));
    }

    /// Make the window the current OpenGL drawing target.
    pub fn makeCurrentWindow(win: *Window) void {
        c.RGFW_window_makeCurrentWindow_OpenGL(cWindow(win));
    }

    /// Make the window's OpenGL context current (or null to detach).
    pub fn makeCurrentContext(win: ?*Window) void {
        c.RGFW_window_makeCurrentContext_OpenGL(if (win) |w| cWindow(w) else null);
    }

    /// Swap the front and back OpenGL buffers for the window.
    pub fn swapBuffers(win: *Window) void {
        c.RGFW_window_swapBuffers_OpenGL(cWindow(win));
    }

    /// Set the OpenGL swap interval (VSync). 0 = off, 1 = on.
    pub fn swapInterval(win: *Window, interval: i32) void {
        c.RGFW_window_swapInterval_OpenGL(cWindow(win), interval);
    }

    /// Get the currently active OpenGL context handle.
    pub fn getCurrentContext() ?*anyopaque {
        return c.RGFW_getCurrentContext_OpenGL();
    }

    /// Get the window that owns the currently active OpenGL context.
    pub fn getCurrentWindow() ?*Window {
        return zigWindow(c.RGFW_getCurrentWindow_OpenGL());
    }

    /// Get a native OpenGL function pointer by name.
    pub fn getProcAddress(procname: [:0]const u8) Proc {
        return c.RGFW_getProcAddress_OpenGL(procname.ptr);
    }

    /// Check if an OpenGL extension is supported in the current context.
    pub fn extensionSupported(extension: []const u8) bool {
        return boolFromC(c.RGFW_extensionSupported_OpenGL(extension.ptr, extension.len));
    }

    /// Check if a platform-specific OpenGL extension is supported.
    pub fn extensionSupportedPlatform(extension: []const u8) bool {
        return boolFromC(c.RGFW_extensionSupportedPlatform_OpenGL(extension.ptr, extension.len));
    }
};

/// EGL context creation and management.
/// Requires RGFW to be compiled with `RGFW_EGL`.
pub const egl = struct {
    /// Create and allocate a new EGL context for a window.
    pub fn createContext(win: *Window, hints: ?*GlHints) ?*EglContext {
        const ctx = c.RGFW_window_createContext_EGL(cWindow(win), if (hints) |h| ptrCast(*c.RGFW_glHints, h) else null);
        return zigEglContext(ctx);
    }

    /// Create an EGL context using a pre-allocated `EglContext` structure.
    pub fn createContextPtr(win: *Window, ctx: *EglContext, hints: ?*GlHints) bool {
        return boolFromC(c.RGFW_window_createContextPtr_EGL(cWindow(win), cEglContext(ctx), if (hints) |h| ptrCast(*c.RGFW_glHints, h) else null));
    }

    /// Delete and free an EGL context.
    pub fn deleteContext(win: *Window, ctx: *EglContext) void {
        c.RGFW_window_deleteContext_EGL(cWindow(win), cEglContext(ctx));
    }

    /// Delete an EGL context without freeing its memory.
    pub fn deleteContextPtr(win: *Window, ctx: *EglContext) void {
        c.RGFW_window_deleteContextPtr_EGL(cWindow(win), cEglContext(ctx));
    }

    /// Get the EGL context associated with a window.
    pub fn getContext(win: *Window) ?*EglContext {
        return zigEglContext(c.RGFW_window_getContext_EGL(cWindow(win)));
    }

    /// Get the EGL display handle.
    pub fn getDisplay() ?*anyopaque {
        return c.RGFW_getDisplay_EGL();
    }

    /// Get the underlying native EGL context handle.
    pub fn contextGetSourceContext(ctx: *EglContext) ?*anyopaque {
        return c.RGFW_eglContext_getSourceContext(cEglContext(ctx));
    }

    /// Get the EGL surface associated with a context.
    pub fn contextGetSurface(ctx: *EglContext) ?*anyopaque {
        return c.RGFW_eglContext_getSurface(cEglContext(ctx));
    }

    /// Get the Wayland EGL window handle (Wayland only).
    pub fn contextWlEglWindow(ctx: *EglContext) ?*WlEglWindow {
        const win = c.RGFW_eglContext_wlEGLWindow(cEglContext(ctx));
        return if (win == null) null else ptrCast(*WlEglWindow, win);
    }

    /// Swap the EGL buffers for a window.
    pub fn swapBuffers(win: *Window) void {
        c.RGFW_window_swapBuffers_EGL(cWindow(win));
    }

    /// Make the window the current EGL rendering target.
    pub fn makeCurrentWindow(win: *Window) void {
        c.RGFW_window_makeCurrentWindow_EGL(cWindow(win));
    }

    /// Make the window's EGL context current (or null to detach).
    pub fn makeCurrentContext(win: ?*Window) void {
        c.RGFW_window_makeCurrentContext_EGL(if (win) |w| cWindow(w) else null);
    }

    /// Get the currently active EGL context handle.
    pub fn getCurrentContext() ?*anyopaque {
        return c.RGFW_getCurrentContext_EGL();
    }

    /// Get the window that owns the currently active EGL context.
    pub fn getCurrentWindow() ?*Window {
        return zigWindow(c.RGFW_getCurrentWindow_EGL());
    }

    /// Set the EGL swap interval (VSync). 0 = off, 1 = on.
    pub fn swapInterval(win: *Window, interval: i32) void {
        c.RGFW_window_swapInterval_EGL(cWindow(win), interval);
    }

    /// Get a native OpenGL/ES function pointer via EGL.
    pub fn getProcAddress(procname: [:0]const u8) Proc {
        return c.RGFW_getProcAddress_EGL(procname.ptr);
    }

    /// Check if an OpenGL/ES extension is supported in the current EGL context.
    pub fn extensionSupported(extension: []const u8) bool {
        return boolFromC(c.RGFW_extensionSupported_EGL(extension.ptr, extension.len));
    }

    /// Check if a platform-dependent EGL extension is supported.
    pub fn extensionSupportedPlatform(extension: []const u8) bool {
        return boolFromC(c.RGFW_extensionSupportedPlatform_EGL(extension.ptr, extension.len));
    }
};

/// Vulkan instance and surface creation helpers.
/// Requires RGFW to be compiled with `RGFW_VULKAN`.
pub const vulkan = struct {
    /// Get a Vulkan function pointer via `vkGetInstanceProcAddr`.
    pub fn getInstanceProcAddress(instance: ?*anyopaque, procname: [:0]const u8) Proc {
        return c.RGFW_getInstanceProcAddress_Vulkan(@ptrCast(instance), procname.ptr);
    }

    /// Get the list of required Vulkan instance extensions for RGFW.
    pub fn getRequiredInstanceExtensions() Error![]const [*:0]const u8 {
        var count: usize = 0;
        const extensions = c.RGFW_getRequiredInstanceExtensions_Vulkan(&count);
        if (extensions == null) return Error.NullPointer;
        return @as([*]const [*:0]const u8, @ptrCast(extensions))[0..count];
    }

    /// Create a Vulkan surface for a window.
    pub fn createSurface(win: *Window, instance: ?*anyopaque, surface_ptr: *anyopaque) i32 {
        return @intFromEnum(c.RGFW_window_createSurface_Vulkan(cWindow(win), @ptrCast(instance), @ptrCast(surface_ptr)));
    }

    /// Check if a Vulkan physical device and queue family support window presentation.
    pub fn getPhysicalDevicePresentationSupport(instance: ?*anyopaque, physical_device: ?*anyopaque, queue_family_index: u32) bool {
        return boolFromC(c.RGFW_getPhysicalDevicePresentationSupport_Vulkan(@ptrCast(instance), @ptrCast(physical_device), @intCast(queue_family_index)));
    }
};

/// DirectX swap chain creation (Windows only).
/// Requires RGFW to be compiled with `RGFW_DIRECTX`.
pub const directx = struct {
    /// Create a DirectX swap chain for the given window.
    pub fn createSwapChain(win: *Window, factory: *DxgiFactory, device: *Unknown, swapchain: **DxgiSwapChain) i32 {
        return @intCast(c.RGFW_window_createSwapChain_DirectX(
            cWindow(win),
            @ptrCast(factory),
            @ptrCast(device),
            @ptrCast(swapchain),
        ));
    }
};

/// WebGPU surface creation helpers.
/// Requires RGFW to be compiled with `RGFW_WEBGPU`.
pub const webgpu = struct {
    /// Create a WebGPU surface for the given window.
    pub fn createSurface(win: *Window, instance: *anyopaque) ?*anyopaque {
        return c.RGFW_window_createSurface_WebGPU(cWindow(win), @ptrCast(instance));
    }
};

/// Low-level platform-specific functions that are normally called internally.
/// These are exposed for advanced use cases and custom platform integration.
pub const platform = struct {
    /// Create a window using the platform backend directly (low-level).
    pub fn createWindow(name: [:0]const u8, flags: WindowFlags, win: *Window) ?*Window {
        return zigWindow(c.RGFW_createWindowPlatform(name.ptr, @as(u32, @bitCast(flags)), cWindow(win)));
    }

    /// Close a window using the platform backend directly (low-level).
    pub fn closeWindow(win: *Window) void {
        c.RGFW_window_closePlatform(cWindow(win));
    }

    /// Set the mouse cursor for a window using the platform backend (low-level).
    pub fn setMouse(win: *Window, mouse_ptr: *Mouse) bool {
        return boolFromC(c.RGFW_window_setMousePlatform(cWindow(win), cMouse(mouse_ptr)));
    }

    /// Set window flags via the internal setFlags path (low-level).
    pub fn setFlagsInternal(win: *Window, flags: WindowFlags, cmp_flags: WindowFlags) void {
        c.RGFW_window_setFlagsInternal(cWindow(win), @as(u32, @bitCast(flags)), @intCast(cmp_flags));
    }

    /// Initialize the X11 platform backend directly.
    pub fn initX11(class_name: ?[:0]const u8, flags: InitFlags) i32 {
        return @intCast(c.RGFW_initPlatform_X11(optionalCString(class_name), @as(u8, @bitCast(flags))));
    }

    /// Deinitialize the X11 platform backend.
    pub fn deinitX11() void {
        c.RGFW_deinitPlatform_X11();
    }

    /// Initialize the Wayland platform backend directly.
    pub fn initWayland(class_name: ?[:0]const u8, flags: InitFlags) i32 {
        return @intCast(c.RGFW_initPlatform_Wayland(optionalCString(class_name), @as(u8, @bitCast(flags))));
    }

    /// Deinitialize the Wayland platform backend.
    pub fn deinitWayland() void {
        c.RGFW_deinitPlatform_Wayland();
    }

    /// Load the X11 shared library functions.
    pub fn loadX11() void {
        c.RGFW_load_X11();
    }

    /// Load the Wayland shared library functions.
    pub fn loadWayland() void {
        c.RGFW_load_Wayland();
    }

    /// Get the current time in nanoseconds (Unix only).
    pub fn unixGetTimeNs() u64 {
        return @intCast(c.RGFW_unix_getTimeNS());
    }

    /// Get the length of a C string (Unix helper).
    pub fn unixStringLen(name: [:0]const u8) usize {
        return c.RGFW_unix_stringlen(name.ptr);
    }

    /// Wait for the X11 window to be shown/mapped (X11 only).
    pub fn waitForShowEventX11(win: *Window) bool {
        return boolFromC(c.RGFW_waitForShowEvent_X11(cWindow(win)));
    }

    /// Get the dark mode state from the Windows registry (Windows only).
    pub fn win32GetDarkModeState() bool {
        return boolFromC(c.RGFW_win32_getDarkModeState());
    }

    /// Apply or remove dark mode for a window (Windows only, requires DWM).
    pub fn win32MakeWindowDarkMode(win: *Window, state: bool) void {
        c.RGFW_win32_makeWindowDarkMode(cWindow(win), boolToC(state));
    }

    /// Extract monitor mode info from a Win32 DEVMODE (Windows only).
    pub fn win32GetMode(dev_mode: *anyopaque, mode: *MonitorMode) void {
        c.RGFW_win32_getMode(@ptrCast(dev_mode), cMonitorMode(mode));
    }

    /// Create a monitor from Win32 adapter and display device names (Windows only).
    pub fn win32CreateMonitor(adapter: *anyopaque, display_device: *anyopaque) void {
        c.RGFW_win32_createMonitor(@ptrCast(adapter), @ptrCast(display_device));
    }

    /// Transform a Y coordinate between Cocoa and RGFW conventions (macOS only).
    pub fn cocoaYTransform(y: f32) f32 {
        return c.RGFW_cocoaYTransform(y);
    }
};

/// Internal helper functions used by the RGFW implementation.
/// Exposed for advanced users who need to replicate or extend internal behavior.
pub const internals = struct {
    /// Initialize an attribute stack for OpenGL context creation.
    pub fn attribStackInit(stack: *anyopaque, attribs: []i32) void {
        c.RGFW_attribStack_init(@ptrCast(stack), attribs.ptr, attribs.len);
    }

    /// Push a single attribute onto the attribute stack.
    pub fn attribStackPushAttrib(stack: *anyopaque, attrib: i32) void {
        c.RGFW_attribStack_pushAttrib(@ptrCast(stack), attrib);
    }

    /// Push a key-value attribute pair onto the attribute stack.
    pub fn attribStackPushAttribs(stack: *anyopaque, attrib1: i32, attrib2: i32) void {
        c.RGFW_attribStack_pushAttribs(@ptrCast(stack), attrib1, attrib2);
    }

    /// Initialize the keycode translation tables.
    pub fn initKeycodes() void {
        c.RGFW_initKeycodes();
    }

    /// Initialize the platform-specific keycode mappings.
    pub fn initKeycodesPlatform() void {
        c.RGFW_initKeycodesPlatform();
    }

    /// Reset the per-frame input previous-state tracking.
    pub fn resetPrevState() void {
        c.RGFW_resetPrevState();
    }

    /// Reset all key states to zero.
    pub fn resetKey() void {
        c.RGFW_resetKey();
    }

    /// Update a single key modifier state.
    pub fn keyUpdateKeyMod(win: *Window, mod: KeyMod, value: bool) void {
        c.RGFW_keyUpdateKeyMod(cWindow(win), @intCast(mod), boolToC(value));
    }

    /// Update common key modifier states (CapsLock, NumLock, ScrollLock).
    pub fn keyUpdateKeyMods(win: *Window, capital: bool, numlock: bool, scroll: bool) void {
        c.RGFW_keyUpdateKeyMods(cWindow(win), boolToC(capital), boolToC(numlock), boolToC(scroll));
    }

    /// Update all key modifier states explicitly.
    pub fn keyUpdateKeyModsEx(win: *Window, capital: bool, numlock: bool, control: bool, alt: bool, shift: bool, super: bool, scroll: bool) void {
        c.RGFW_keyUpdateKeyModsEx(cWindow(win), boolToC(capital), boolToC(numlock), boolToC(control), boolToC(alt), boolToC(shift), boolToC(super), boolToC(scroll));
    }

    /// Load the native OpenGL library.
    pub fn loadGl() bool {
        return boolFromC(c.RGFW_loadGL());
    }

    /// Unload the native OpenGL library.
    pub fn unloadGl() void {
        c.RGFW_unloadGL();
    }

    /// Load the EGL library.
    pub fn loadEgl() bool {
        return boolFromC(c.RGFW_loadEGL());
    }

    /// Unload the EGL library.
    pub fn unloadEgl() void {
        c.RGFW_unloadEGL();
    }

    /// Load the Vulkan library.
    pub fn loadVulkan() bool {
        return boolFromC(c.RGFW_loadVulkan());
    }

    /// Unload the Vulkan library.
    pub fn unloadVulkan() void {
        c.RGFW_unloadVulkan();
    }

    /// Refresh the monitor list by removing disconnected monitors.
    pub fn monitorsRefresh() void {
        c.RGFW_monitors_refresh();
    }

    /// Add a monitor to the internal monitor list.
    pub fn monitorsAdd(mon: *const Monitor) ?*MonitorNode {
        return zigMonitorNode(c.RGFW_monitors_add(ptrCast(*const c.RGFW_monitor, mon)));
    }

    /// Remove a monitor node from the internal monitor list.
    pub fn monitorsRemove(node: *MonitorNode, prev: *MonitorNode) void {
        c.RGFW_monitors_remove(cMonitorNode(node), cMonitorNode(prev));
    }

    /// Free a monitor node's internal data.
    pub fn monitorNodeFree(node: *MonitorNode) void {
        c.RGFW_monitorNode_free(cMonitorNode(node));
    }

    /// Set or clear a bit in a u32 value.
    pub fn setBit(value: *u32, mask: u32, set: bool) void {
        c.RGFW_setBit(value, mask, boolToC(set));
    }

    /// Split a BPP (bits-per-pixel) value into RGB channel bit depths.
    pub fn splitBpp(bpp: u32, mode: *MonitorMode) void {
        c.RGFW_splitBPP(bpp, cMonitorMode(mode));
    }

    /// Update the window mouse flags (show/hide state).
    pub fn windowShowMouseFlags(win: *Window, visible: bool) void {
        c.RGFW_window_showMouseFlags(cWindow(win), boolToC(visible));
    }

    /// Platform-specific mouse capture implementation.
    pub fn windowCaptureMousePlatform(win: *Window, state: bool) void {
        c.RGFW_window_captureMousePlatform(cWindow(win), boolToC(state));
    }

    /// Platform-specific raw mouse mode implementation.
    pub fn windowSetRawMouseModePlatform(win: *Window, state: bool) void {
        c.RGFW_window_setRawMouseModePlatform(cWindow(win), boolToC(state));
    }
};

/// Callback stubs for internal event dispatch. These are called by the platform
/// backends when events occur and in turn push events to the queue and call user callbacks.
pub const callbacks = struct {
    /// Called when the window is maximized.
    pub fn windowMaximized(win: *Window, rect: Rect) void {
        c.RGFW_windowMaximizedCallback(cWindow(win), rect.x, rect.y, rect.w, rect.h);
    }

    /// Called when the window is minimized.
    pub fn windowMinimized(win: *Window) void {
        c.RGFW_windowMinimizedCallback(cWindow(win));
    }

    /// Called when the window is restored from minimized/maximized state.
    pub fn windowRestored(win: *Window, rect: Rect) void {
        c.RGFW_windowRestoredCallback(cWindow(win), rect.x, rect.y, rect.w, rect.h);
    }

    /// Called when the window is moved.
    pub fn windowMoved(win: *Window, pos: Position) void {
        c.RGFW_windowMovedCallback(cWindow(win), pos.x, pos.y);
    }

    /// Called when the window is resized.
    pub fn windowResized(win: *Window, size: Size) void {
        c.RGFW_windowResizedCallback(cWindow(win), size.w, size.h);
    }

    /// Called when the user attempts to close the window.
    pub fn windowClose(win: *Window) void {
        c.RGFW_windowCloseCallback(cWindow(win));
    }

    /// Called when the mouse moves within the window.
    pub fn mouseMotion(win: *Window, pos: Position) void {
        c.RGFW_mouseMotionCallback(cWindow(win), pos.x, pos.y);
    }

    /// Called when raw (unaccelerated) mouse motion is detected.
    pub fn rawMotion(win: *Window, vector: MouseVector) void {
        c.RGFW_rawMotionCallback(cWindow(win), vector.x, vector.y);
    }

    /// Called when the window content needs to be redrawn.
    pub fn windowRefresh(win: *Window, rect: Rect) void {
        c.RGFW_windowRefreshCallback(cWindow(win), rect.x, rect.y, rect.w, rect.h);
    }

    /// Called when the window gains or loses focus.
    pub fn windowFocus(win: *Window, in_focus: bool) void {
        c.RGFW_windowFocusCallback(cWindow(win), boolToC(in_focus));
    }

    /// Called when the mouse enters or leaves the window.
    pub fn mouseNotify(win: *Window, pos: Position, status: bool) void {
        c.RGFW_mouseNotifyCallback(cWindow(win), pos.x, pos.y, boolToC(status));
    }

    /// Called when data is dropped onto the window.
    pub fn dataDrop(win: *Window, data: [:0]const u8, data_type: DataTransferType) void {
        c.RGFW_dataDropCallback(cWindow(win), data.ptr, data.len, @intCast(data_type));
    }

    /// Called during a drag-and-drop operation over the window.
    pub fn dataDrag(win: *Window, data_type: DataTransferType, action: DndActionType, pos: Position) void {
        c.RGFW_dataDragCallback(cWindow(win), @intCast(data_type), @intCast(action), pos.x, pos.y);
    }

    /// Called when a UTF-8 character is typed.
    pub fn keyChar(win: *Window, codepoint: u32) void {
        c.RGFW_keyCharCallback(cWindow(win), codepoint);
    }

    /// Called when a key is pressed or released.
    pub fn keyEvent(win: *Window, key_code: Key, mod: KeyMod, repeat: bool, press: bool) void {
        c.RGFW_keyCallback(cWindow(win), @intFromEnum(key_code), @intCast(mod), boolToC(repeat), boolToC(press));
    }

    /// Called when a mouse button is pressed or released.
    pub fn mouseButton(win: *Window, button: MouseButton, press: bool) void {
        c.RGFW_mouseButtonCallback(cWindow(win), @intFromEnum(button), boolToC(press));
    }

    /// Called when the mouse scroll wheel is used.
    pub fn mouseScroll(win: *Window, vector: MouseVector) void {
        c.RGFW_mouseScrollCallback(cWindow(win), vector.x, vector.y);
    }

    /// Called when the content scale (DPI) of the window changes.
    pub fn scaleUpdated(win: *Window, scale: Scale) void {
        c.RGFW_scaleUpdatedCallback(cWindow(win), scale.x, scale.y);
    }

    /// Called when a monitor is connected or disconnected.
    pub fn monitor(win: *Window, mon: *const Monitor, connected: bool) void {
        c.RGFW_monitorCallback(cWindow(win), ptrCast(*const c.RGFW_monitor, mon), boolToC(connected));
    }
};

/// Native platform internals (OS-specific helpers for advanced use).
pub const native = struct {
    /// Initialize the macOS NSView for a window (macOS only).
    pub fn osxInitView(win: *Window) void {
        c.RGFW_osx_initView(cWindow(win));
    }

    /// Get the NSScreen for a given CGDirectDisplayID (macOS only).
    pub fn getNSScreenForDisplayUInt(display_id: u32) ?*anyopaque {
        return c.RGFW_getNSScreenForDisplayUInt(display_id);
    }

    /// Parse a dropped URI list into file paths and call the data drop callback (Unix only).
    pub fn unixParseUri(win: *Window, data: [:0]u8) void {
        c.RGFW_unix_parseURI(cWindow(win), data.ptr);
    }

    /// Get the Win32 window style flags for the given RGFW flags (Windows only).
    pub fn winapiWindowGetStyle(win: *Window, flags: WindowFlags) u32 {
        return @intCast(c.RGFW_winapi_window_getStyle(cWindow(win), @as(u32, @bitCast(flags))));
    }

    /// Get the Win32 extended window style flags (Windows only).
    pub fn winapiWindowGetExStyle(win: *Window, flags: WindowFlags) u32 {
        return @intCast(c.RGFW_winapi_window_getExStyle(cWindow(win), @as(u32, @bitCast(flags))));
    }

    /// Get the system content DPI via X11 XResources (X11 only).
    pub fn xGetSystemContentDpi() f32 {
        var dpi: f32 = 0;
        c.RGFW_XGetSystemContentDPI(&dpi);
        return dpi;
    }

    /// Handle an X11 clipboard selection request event (X11 only).
    pub fn xHandleClipboardSelection(event: *anyopaque) void {
        c.RGFW_XHandleClipboardSelection(@ptrCast(event));
    }

    /// Process a single X11 event from the display queue (X11 only).
    pub fn xHandleEvent() void {
        c.RGFW_XHandleEvent();
    }

    /// Determine the RGFW pixel format from an X11 XImage (X11 only).
    pub fn xImageGetFormat(image: *anyopaque) Format {
        return @intCast(c.RGFW_XImage_getFormat(@ptrCast(image)));
    }

    /// Custom X11 error handler (X11 only).
    pub fn xErrorHandler(display: *anyopaque, event: *anyopaque) i32 {
        return @intCast(c.RGFW_XErrorHandler(@ptrCast(display), @ptrCast(event)));
    }

    /// X11 input method context destruction callback (X11 only).
    pub fn x11IcCallback(ic: *anyopaque, client_data: [*:0]u8, call_data: [*:0]u8) void {
        c.RGFW_x11_icCallback(@ptrCast(ic), client_data, call_data);
    }

    /// X11 input method destruction callback (X11 only).
    pub fn x11ImCallback(im: *anyopaque, client_data: [*:0]u8, call_data: [*:0]u8) void {
        c.RGFW_x11_imCallback(@ptrCast(im), client_data, call_data);
    }

    /// X11 input method instantiation callback (X11 only).
    pub fn x11ImInitCallback(display: *anyopaque, client_data: *anyopaque, call_data: *anyopaque) void {
        c.RGFW_x11_imInitCallback(@ptrCast(display), @ptrCast(client_data), @ptrCast(call_data));
    }

    /// Get an X11 mode info structure by mode ID (X11 only).
    pub fn xGetMode(crtc_info: *anyopaque, resources: *anyopaque, mode_id: u64, found_mode: *MonitorMode) ?*anyopaque {
        return c.RGFW_XGetMode(@ptrCast(crtc_info), @ptrCast(resources), @intCast(mode_id), cMonitorMode(found_mode));
    }

    /// Get an X11 VisualInfo for window creation (X11 only).
    pub fn windowGetVisual(visual: *anyopaque, transparent: bool) void {
        c.RGFW_window_getVisual(@ptrCast(visual), boolToC(transparent));
    }
};
