const c = @cImport({
    @cInclude("RGFW.h");
});

pub const Error = error{
    MissingDeclaration,
    NullPointer,
};

pub const Window = opaque {};
pub const WindowSrc = opaque {};
pub const Info = opaque {};
pub const Surface = opaque {};
pub const NativeImage = opaque {};
pub const Mouse = opaque {};
pub const Monitor = opaque {};
pub const GlContext = opaque {};
pub const EglContext = opaque {};
pub const DxgiFactory = opaque {};
pub const Unknown = opaque {};
pub const DxgiSwapChain = opaque {};
pub const MonitorNode = opaque {};
pub const WlDisplay = opaque {};
pub const WlSurface = opaque {};
pub const WlEglWindow = opaque {};

pub const Key = u8;
pub const MouseButton = u8;
pub const KeyMod = u8;
pub const InitFlags = u8;
pub const Format = u8;
pub const ModeRequest = u8;
pub const DndActionType = u8;
pub const DataTransferType = u8;
pub const EventType = u8;
pub const EventFlag = u32;
pub const EventWait = i32;
pub const WindowFlags = u32;
pub const Icon = u8;
pub const MouseIcon = u8;
pub const FlashRequest = u8;
pub const DebugType = u8;
pub const ErrorCode = u8;
pub const GlReleaseBehavior = i32;
pub const GlProfile = i32;
pub const GlRenderer = i32;

pub const ColorLayout = extern struct {
    r: i32,
    g: i32,
    b: i32,
    a: i32,
    channels: u32,
};

pub const GammaRamp = extern struct {
    red: [*]u16,
    green: [*]u16,
    blue: [*]u16,
    size: usize,
};

pub const MonitorMode = extern struct {
    w: i32,
    h: i32,
    refreshRate: i32,
    red: u8,
    green: u8,
    blue: u8,
};

pub const Position = struct {
    x: i32,
    y: i32,
};

pub const Size = struct {
    w: i32,
    h: i32,
};

pub const Scale = struct {
    x: f32,
    y: f32,
};

pub const Rect = struct {
    x: i32,
    y: i32,
    w: i32,
    h: i32,
};

pub const MouseVector = struct {
    x: f32,
    y: f32,
};

pub const Image = struct {
    data: []u8,
    w: i32,
    h: i32,
    format: Format,
};

pub const Event = c.RGFW_event;
pub const DataTransfer = c.RGFW_dataTransfer;
pub const DataDropNode = c.RGFW_dataDropNode;
pub const Callbacks = c.RGFW_callbacks;
pub const GlHints = c.RGFW_glHints;
pub const Proc = c.RGFW_proc;
pub const ProcLoader = *const fn ([:0]const u8) callconv(.c) Proc;
pub const GenericFunc = c.RGFW_genericFunc;
pub const DebugFunc = c.RGFW_debugFunc;
pub const ConvertImageDataFunc = c.RGFW_convertImageDataFunc;

pub const initFlag = struct {
    pub const openGl: InitFlags = @intCast(c.RGFW_initOpenGL);
    pub const egl: InitFlags = @intCast(c.RGFW_initEGL);
    pub const vulkan: InitFlags = @intCast(c.RGFW_initVulkan);
    pub const x11: InitFlags = @intCast(c.RGFW_initX11);
};

pub const format = struct {
    pub const rgb8: Format = @intCast(c.RGFW_formatRGB8);
    pub const rgba8: Format = @intCast(c.RGFW_formatRGBA8);
    pub const argb8: Format = @intCast(c.RGFW_formatARGB8);
    pub const abgr8: Format = @intCast(c.RGFW_formatABGR8);
    pub const bgra8: Format = @intCast(c.RGFW_formatBGRA8);
    pub const bgr8: Format = @intCast(c.RGFW_formatBGR8);
};

pub const modeRequest = struct {
    pub const scale: ModeRequest = @intCast(c.RGFW_monitorScale);
    pub const refresh: ModeRequest = @intCast(c.RGFW_monitorRefresh);
    pub const rgb: ModeRequest = @intCast(c.RGFW_monitorRGB);
    pub const all: ModeRequest = @intCast(c.RGFW_monitorAll);
};

pub const key = struct {
    pub const none: Key = @intCast(c.RGFW_keyNULL);
    pub const escape: Key = @intCast(c.RGFW_keyEscape);
    pub const backtick: Key = @intCast(c.RGFW_keyBacktick);
    pub const space: Key = @intCast(c.RGFW_keySpace);
    pub const enter: Key = @intCast(c.RGFW_keyEnter);
    pub const tab: Key = @intCast(c.RGFW_keyTab);
    pub const backspace: Key = @intCast(c.RGFW_keyBackSpace);
    pub const delete: Key = @intCast(c.RGFW_keyDelete);
    pub const returnKey: Key = @intCast(c.RGFW_keyReturn);
    pub const minus: Key = @intCast(c.RGFW_keyMinus);
    pub const equal: Key = @intCast(c.RGFW_keyEqual);
    pub const equals: Key = @intCast(c.RGFW_keyEquals);
    pub const period: Key = @intCast(c.RGFW_keyPeriod);
    pub const comma: Key = @intCast(c.RGFW_keyComma);
    pub const slash: Key = @intCast(c.RGFW_keySlash);
    pub const bracket: Key = @intCast(c.RGFW_keyBracket);
    pub const closeBracket: Key = @intCast(c.RGFW_keyCloseBracket);
    pub const semicolon: Key = @intCast(c.RGFW_keySemicolon);
    pub const apostrophe: Key = @intCast(c.RGFW_keyApostrophe);
    pub const backslash: Key = @intCast(c.RGFW_keyBackSlash);
    pub const capsLock: Key = @intCast(c.RGFW_keyCapsLock);
    pub const shiftLeft: Key = @intCast(c.RGFW_keyShiftL);
    pub const controlLeft: Key = @intCast(c.RGFW_keyControlL);
    pub const altLeft: Key = @intCast(c.RGFW_keyAltL);
    pub const superLeft: Key = @intCast(c.RGFW_keySuperL);
    pub const shiftRight: Key = @intCast(c.RGFW_keyShiftR);
    pub const controlRight: Key = @intCast(c.RGFW_keyControlR);
    pub const altRight: Key = @intCast(c.RGFW_keyAltR);
    pub const superRight: Key = @intCast(c.RGFW_keySuperR);
    pub const up: Key = @intCast(c.RGFW_keyUp);
    pub const down: Key = @intCast(c.RGFW_keyDown);
    pub const left: Key = @intCast(c.RGFW_keyLeft);
    pub const right: Key = @intCast(c.RGFW_keyRight);
    pub const insert: Key = @intCast(c.RGFW_keyInsert);
    pub const menu: Key = @intCast(c.RGFW_keyMenu);
    pub const home: Key = @intCast(c.RGFW_keyHome);
    pub const end: Key = @intCast(c.RGFW_keyEnd);
    pub const pageUp: Key = @intCast(c.RGFW_keyPageUp);
    pub const pageDown: Key = @intCast(c.RGFW_keyPageDown);
    pub const numLock: Key = @intCast(c.RGFW_keyNumLock);
    pub const padSlash: Key = @intCast(c.RGFW_keyPadSlash);
    pub const padMultiply: Key = @intCast(c.RGFW_keyPadMultiply);
    pub const padPlus: Key = @intCast(c.RGFW_keyPadPlus);
    pub const padMinus: Key = @intCast(c.RGFW_keyPadMinus);
    pub const padEqual: Key = @intCast(c.RGFW_keyPadEqual);
    pub const padEquals: Key = @intCast(c.RGFW_keyPadEquals);
    pub const pad1: Key = @intCast(c.RGFW_keyPad1);
    pub const pad2: Key = @intCast(c.RGFW_keyPad2);
    pub const pad3: Key = @intCast(c.RGFW_keyPad3);
    pub const pad4: Key = @intCast(c.RGFW_keyPad4);
    pub const pad5: Key = @intCast(c.RGFW_keyPad5);
    pub const pad6: Key = @intCast(c.RGFW_keyPad6);
    pub const pad7: Key = @intCast(c.RGFW_keyPad7);
    pub const pad8: Key = @intCast(c.RGFW_keyPad8);
    pub const pad9: Key = @intCast(c.RGFW_keyPad9);
    pub const pad0: Key = @intCast(c.RGFW_keyPad0);
    pub const padPeriod: Key = @intCast(c.RGFW_keyPadPeriod);
    pub const padReturn: Key = @intCast(c.RGFW_keyPadReturn);
    pub const scrollLock: Key = @intCast(c.RGFW_keyScrollLock);
    pub const printScreen: Key = @intCast(c.RGFW_keyPrintScreen);
    pub const pause: Key = @intCast(c.RGFW_keyPause);
    pub const world1: Key = @intCast(c.RGFW_keyWorld1);
    pub const world2: Key = @intCast(c.RGFW_keyWorld2);
    pub const a: Key = @intCast(c.RGFW_keyA);
    pub const b: Key = @intCast(c.RGFW_keyB);
    pub const cKey: Key = @intCast(c.RGFW_keyC);
    pub const d: Key = @intCast(c.RGFW_keyD);
    pub const e: Key = @intCast(c.RGFW_keyE);
    pub const f: Key = @intCast(c.RGFW_keyF);
    pub const g: Key = @intCast(c.RGFW_keyG);
    pub const h: Key = @intCast(c.RGFW_keyH);
    pub const i: Key = @intCast(c.RGFW_keyI);
    pub const j: Key = @intCast(c.RGFW_keyJ);
    pub const k: Key = @intCast(c.RGFW_keyK);
    pub const l: Key = @intCast(c.RGFW_keyL);
    pub const m: Key = @intCast(c.RGFW_keyM);
    pub const n: Key = @intCast(c.RGFW_keyN);
    pub const o: Key = @intCast(c.RGFW_keyO);
    pub const p: Key = @intCast(c.RGFW_keyP);
    pub const q: Key = @intCast(c.RGFW_keyQ);
    pub const r: Key = @intCast(c.RGFW_keyR);
    pub const s: Key = @intCast(c.RGFW_keyS);
    pub const t: Key = @intCast(c.RGFW_keyT);
    pub const u: Key = @intCast(c.RGFW_keyU);
    pub const v: Key = @intCast(c.RGFW_keyV);
    pub const w: Key = @intCast(c.RGFW_keyW);
    pub const x: Key = @intCast(c.RGFW_keyX);
    pub const y: Key = @intCast(c.RGFW_keyY);
    pub const z: Key = @intCast(c.RGFW_keyZ);
    pub const zero: Key = @intCast(c.RGFW_key0);
    pub const one: Key = @intCast(c.RGFW_key1);
    pub const two: Key = @intCast(c.RGFW_key2);
    pub const three: Key = @intCast(c.RGFW_key3);
    pub const four: Key = @intCast(c.RGFW_key4);
    pub const five: Key = @intCast(c.RGFW_key5);
    pub const six: Key = @intCast(c.RGFW_key6);
    pub const seven: Key = @intCast(c.RGFW_key7);
    pub const eight: Key = @intCast(c.RGFW_key8);
    pub const nine: Key = @intCast(c.RGFW_key9);
    pub const f1: Key = @intCast(c.RGFW_keyF1);
    pub const f2: Key = @intCast(c.RGFW_keyF2);
    pub const f3: Key = @intCast(c.RGFW_keyF3);
    pub const f4: Key = @intCast(c.RGFW_keyF4);
    pub const f5: Key = @intCast(c.RGFW_keyF5);
    pub const f6: Key = @intCast(c.RGFW_keyF6);
    pub const f7: Key = @intCast(c.RGFW_keyF7);
    pub const f8: Key = @intCast(c.RGFW_keyF8);
    pub const f9: Key = @intCast(c.RGFW_keyF9);
    pub const f10: Key = @intCast(c.RGFW_keyF10);
    pub const f11: Key = @intCast(c.RGFW_keyF11);
    pub const f12: Key = @intCast(c.RGFW_keyF12);
    pub const f13: Key = @intCast(c.RGFW_keyF13);
    pub const f14: Key = @intCast(c.RGFW_keyF14);
    pub const f15: Key = @intCast(c.RGFW_keyF15);
    pub const f16Key: Key = @intCast(c.RGFW_keyF16);
    pub const f17: Key = @intCast(c.RGFW_keyF17);
    pub const f18: Key = @intCast(c.RGFW_keyF18);
    pub const f19: Key = @intCast(c.RGFW_keyF19);
    pub const f20: Key = @intCast(c.RGFW_keyF20);
    pub const f21: Key = @intCast(c.RGFW_keyF21);
    pub const f22: Key = @intCast(c.RGFW_keyF22);
    pub const f23: Key = @intCast(c.RGFW_keyF23);
    pub const f24: Key = @intCast(c.RGFW_keyF24);
    pub const f25: Key = @intCast(c.RGFW_keyF25);
    pub const last: Key = @intCast(c.RGFW_keyLast);
};

pub const mouseButton = struct {
    pub const left: MouseButton = @intCast(c.RGFW_mouseLeft);
    pub const middle: MouseButton = @intCast(c.RGFW_mouseMiddle);
    pub const right: MouseButton = @intCast(c.RGFW_mouseRight);
    pub const misc1: MouseButton = @intCast(c.RGFW_mouseMisc1);
    pub const misc2: MouseButton = @intCast(c.RGFW_mouseMisc2);
    pub const misc3: MouseButton = @intCast(c.RGFW_mouseMisc3);
    pub const misc4: MouseButton = @intCast(c.RGFW_mouseMisc4);
    pub const misc5: MouseButton = @intCast(c.RGFW_mouseMisc5);
};

pub const keyMod = struct {
    pub const capsLock: KeyMod = @intCast(c.RGFW_modCapsLock);
    pub const numLock: KeyMod = @intCast(c.RGFW_modNumLock);
    pub const control: KeyMod = @intCast(c.RGFW_modControl);
    pub const alt: KeyMod = @intCast(c.RGFW_modAlt);
    pub const shift: KeyMod = @intCast(c.RGFW_modShift);
    pub const super: KeyMod = @intCast(c.RGFW_modSuper);
    pub const scrollLock: KeyMod = @intCast(c.RGFW_modScrollLock);
};

pub const eventType = struct {
    pub const none: EventType = @intCast(c.RGFW_eventNone);
    pub const keyPressed: EventType = @intCast(c.RGFW_keyPressed);
    pub const keyReleased: EventType = @intCast(c.RGFW_keyReleased);
    pub const keyChar: EventType = @intCast(c.RGFW_keyChar);
    pub const mouseButtonPressed: EventType = @intCast(c.RGFW_mouseButtonPressed);
    pub const mouseButtonReleased: EventType = @intCast(c.RGFW_mouseButtonReleased);
    pub const mouseScroll: EventType = @intCast(c.RGFW_mouseScroll);
    pub const mouseMotion: EventType = @intCast(c.RGFW_mouseMotion);
    pub const mouseRawMotion: EventType = @intCast(c.RGFW_mouseRawMotion);
    pub const mouseEnter: EventType = @intCast(c.RGFW_mouseEnter);
    pub const mouseLeave: EventType = @intCast(c.RGFW_mouseLeave);
    pub const windowMoved: EventType = @intCast(c.RGFW_windowMoved);
    pub const windowResized: EventType = @intCast(c.RGFW_windowResized);
    pub const windowFocusIn: EventType = @intCast(c.RGFW_windowFocusIn);
    pub const windowFocusOut: EventType = @intCast(c.RGFW_windowFocusOut);
    pub const windowRefresh: EventType = @intCast(c.RGFW_windowRefresh);
    pub const windowClose: EventType = @intCast(c.RGFW_windowClose);
    pub const windowMaximized: EventType = @intCast(c.RGFW_windowMaximized);
    pub const windowMinimized: EventType = @intCast(c.RGFW_windowMinimized);
    pub const windowRestored: EventType = @intCast(c.RGFW_windowRestored);
    pub const dataDrop: EventType = @intCast(c.RGFW_dataDrop);
    pub const dataDrag: EventType = @intCast(c.RGFW_dataDrag);
    pub const scaleUpdated: EventType = @intCast(c.RGFW_scaleUpdated);
    pub const monitorConnected: EventType = @intCast(c.RGFW_monitorConnected);
    pub const monitorDisconnected: EventType = @intCast(c.RGFW_monitorDisconnected);
    pub const count: EventType = @intCast(c.RGFW_eventCount);
    pub const mousePosChanged: EventType = @intCast(c.RGFW_mousePosChanged);
};

pub const eventFlag = struct {
    pub const keyPressed: EventFlag = @intCast(c.RGFW_keyPressedFlag);
    pub const keyReleased: EventFlag = @intCast(c.RGFW_keyReleasedFlag);
    pub const keyChar: EventFlag = @intCast(c.RGFW_keyCharFlag);
    pub const mouseScroll: EventFlag = @intCast(c.RGFW_mouseScrollFlag);
    pub const mouseButtonPressed: EventFlag = @intCast(c.RGFW_mouseButtonPressedFlag);
    pub const mouseButtonReleased: EventFlag = @intCast(c.RGFW_mouseButtonReleasedFlag);
    pub const mouseMotion: EventFlag = @intCast(c.RGFW_mouseMotionFlag);
    pub const mouseRawMotion: EventFlag = @intCast(c.RGFW_mouseRawMotionFlag);
    pub const mouseEnter: EventFlag = @intCast(c.RGFW_mouseEnterFlag);
    pub const mouseLeave: EventFlag = @intCast(c.RGFW_mouseLeaveFlag);
    pub const windowMoved: EventFlag = @intCast(c.RGFW_windowMovedFlag);
    pub const windowResized: EventFlag = @intCast(c.RGFW_windowResizedFlag);
    pub const windowFocusIn: EventFlag = @intCast(c.RGFW_windowFocusInFlag);
    pub const windowFocusOut: EventFlag = @intCast(c.RGFW_windowFocusOutFlag);
    pub const windowRefresh: EventFlag = @intCast(c.RGFW_windowRefreshFlag);
    pub const windowMaximized: EventFlag = @intCast(c.RGFW_windowMaximizedFlag);
    pub const windowMinimized: EventFlag = @intCast(c.RGFW_windowMinimizedFlag);
    pub const windowRestored: EventFlag = @intCast(c.RGFW_windowRestoredFlag);
    pub const scaleUpdated: EventFlag = @intCast(c.RGFW_scaleUpdatedFlag);
    pub const windowClose: EventFlag = @intCast(c.RGFW_windowCloseFlag);
    pub const dataDrop: EventFlag = @intCast(c.RGFW_dataDropFlag);
    pub const dataDrag: EventFlag = @intCast(c.RGFW_dataDragFlag);
    pub const monitorConnected: EventFlag = @intCast(c.RGFW_monitorConnectedFlag);
    pub const monitorDisconnected: EventFlag = @intCast(c.RGFW_monitorDisconnectedFlag);
    pub const mousePosChanged: EventFlag = @intCast(c.RGFW_mousePosChangedFlag);
    pub const keyEvents: EventFlag = @intCast(c.RGFW_keyEventsFlag);
    pub const mouseEvents: EventFlag = @intCast(c.RGFW_mouseEventsFlag);
    pub const windowEvents: EventFlag = @intCast(c.RGFW_windowEventsFlag);
    pub const windowFocusEvents: EventFlag = @intCast(c.RGFW_windowFocusEventsFlag);
    pub const dataDragDropEvents: EventFlag = @intCast(c.RGFW_dataDragDropEventsFlag);
    pub const monitorEvents: EventFlag = @intCast(c.RGFW_monitorEventsFlag);
    pub const all: EventFlag = @intCast(c.RGFW_allEventFlags);
};

pub const eventWait = struct {
    pub const noWait: EventWait = @intCast(c.RGFW_eventNoWait);
    pub const waitNext: EventWait = @intCast(c.RGFW_eventWaitNext);
};

pub const dndAction = struct {
    pub const none: DndActionType = @intCast(c.RGFW_dndActionNone);
    pub const enter: DndActionType = @intCast(c.RGFW_dndActionEnter);
    pub const move: DndActionType = @intCast(c.RGFW_dndActionMove);
    pub const exit: DndActionType = @intCast(c.RGFW_dndActionExit);
};

pub const dataTransfer = struct {
    pub const none: DataTransferType = @intCast(c.RGFW_dataNone);
    pub const text: DataTransferType = @intCast(c.RGFW_dataText);
    pub const file: DataTransferType = @intCast(c.RGFW_dataFile);
    pub const url: DataTransferType = @intCast(c.RGFW_dataURL);
    pub const image: DataTransferType = @intCast(c.RGFW_dataImage);
    pub const unknown: DataTransferType = @intCast(c.RGFW_dataUnknown);
};

pub const windowFlag = struct {
    pub const noBorder: WindowFlags = @intCast(c.RGFW_windowNoBorder);
    pub const noResize: WindowFlags = @intCast(c.RGFW_windowNoResize);
    pub const allowDnd: WindowFlags = @intCast(c.RGFW_windowAllowDND);
    pub const hideMouse: WindowFlags = @intCast(c.RGFW_windowHideMouse);
    pub const fullscreen: WindowFlags = @intCast(c.RGFW_windowFullscreen);
    pub const translucent: WindowFlags = @intCast(c.RGFW_windowTranslucent);
    pub const transparent: WindowFlags = @intCast(c.RGFW_windowTransparent);
    pub const center: WindowFlags = @intCast(c.RGFW_windowCenter);
    pub const rawMouse: WindowFlags = @intCast(c.RGFW_windowRawMouse);
    pub const scaleToMonitor: WindowFlags = @intCast(c.RGFW_windowScaleToMonitor);
    pub const hide: WindowFlags = @intCast(c.RGFW_windowHide);
    pub const maximize: WindowFlags = @intCast(c.RGFW_windowMaximize);
    pub const centerCursor: WindowFlags = @intCast(c.RGFW_windowCenterCursor);
    pub const floating: WindowFlags = @intCast(c.RGFW_windowFloating);
    pub const focusOnShow: WindowFlags = @intCast(c.RGFW_windowFocusOnShow);
    pub const minimize: WindowFlags = @intCast(c.RGFW_windowMinimize);
    pub const focus: WindowFlags = @intCast(c.RGFW_windowFocus);
    pub const captureMouse: WindowFlags = @intCast(c.RGFW_windowCaptureMouse);
    pub const openGl: WindowFlags = @intCast(c.RGFW_windowOpenGL);
    pub const egl: WindowFlags = @intCast(c.RGFW_windowEGL);
    pub const windowedFullscreen: WindowFlags = @intCast(c.RGFW_windowedFullscreen);
    pub const captureRawMouse: WindowFlags = @intCast(c.RGFW_windowCaptureRawMouse);
};

pub const icon = struct {
    pub const taskbar: Icon = @intCast(c.RGFW_iconTaskbar);
    pub const window: Icon = @intCast(c.RGFW_iconWindow);
    pub const both: Icon = @intCast(c.RGFW_iconBoth);
};

pub const mouseIcon = struct {
    pub const normal: MouseIcon = @intCast(c.RGFW_mouseNormal);
    pub const arrow: MouseIcon = @intCast(c.RGFW_mouseArrow);
    pub const ibeam: MouseIcon = @intCast(c.RGFW_mouseIbeam);
    pub const text: MouseIcon = @intCast(c.RGFW_mouseText);
    pub const crosshair: MouseIcon = @intCast(c.RGFW_mouseCrosshair);
    pub const pointingHand: MouseIcon = @intCast(c.RGFW_mousePointingHand);
    pub const resizeEw: MouseIcon = @intCast(c.RGFW_mouseResizeEW);
    pub const resizeNs: MouseIcon = @intCast(c.RGFW_mouseResizeNS);
    pub const resizeNwse: MouseIcon = @intCast(c.RGFW_mouseResizeNWSE);
    pub const resizeNesw: MouseIcon = @intCast(c.RGFW_mouseResizeNESW);
    pub const resizeNw: MouseIcon = @intCast(c.RGFW_mouseResizeNW);
    pub const resizeN: MouseIcon = @intCast(c.RGFW_mouseResizeN);
    pub const resizeNe: MouseIcon = @intCast(c.RGFW_mouseResizeNE);
    pub const resizeE: MouseIcon = @intCast(c.RGFW_mouseResizeE);
    pub const resizeSe: MouseIcon = @intCast(c.RGFW_mouseResizeSE);
    pub const resizeS: MouseIcon = @intCast(c.RGFW_mouseResizeS);
    pub const resizeSw: MouseIcon = @intCast(c.RGFW_mouseResizeSW);
    pub const resizeW: MouseIcon = @intCast(c.RGFW_mouseResizeW);
    pub const resizeAll: MouseIcon = @intCast(c.RGFW_mouseResizeAll);
    pub const notAllowed: MouseIcon = @intCast(c.RGFW_mouseNotAllowed);
    pub const wait: MouseIcon = @intCast(c.RGFW_mouseWait);
    pub const progress: MouseIcon = @intCast(c.RGFW_mouseProgress);
    pub const count: MouseIcon = @intCast(c.RGFW_mouseIconCount);
    pub const final: MouseIcon = @intCast(c.RGFW_mouseIconFinal);
};

pub const flashRequest = struct {
    pub const cancel: FlashRequest = @intCast(c.RGFW_flashCancel);
    pub const briefly: FlashRequest = @intCast(c.RGFW_flashBriefly);
    pub const untilFocused: FlashRequest = @intCast(c.RGFW_flashUntilFocused);
};

pub const debugType = struct {
    pub const err: DebugType = @intCast(c.RGFW_typeError);
    pub const warning: DebugType = @intCast(c.RGFW_typeWarning);
    pub const info: DebugType = @intCast(c.RGFW_typeInfo);
};

pub const errorCode = struct {
    pub const none: ErrorCode = @intCast(c.RGFW_noError);
    pub const outOfMemory: ErrorCode = @intCast(c.RGFW_errOutOfMemory);
    pub const openGlContext: ErrorCode = @intCast(c.RGFW_errOpenGLContext);
    pub const eglContext: ErrorCode = @intCast(c.RGFW_errEGLContext);
    pub const wayland: ErrorCode = @intCast(c.RGFW_errWayland);
    pub const x11: ErrorCode = @intCast(c.RGFW_errX11);
    pub const directxContext: ErrorCode = @intCast(c.RGFW_errDirectXContext);
    pub const ioKit: ErrorCode = @intCast(c.RGFW_errIOKit);
    pub const clipboard: ErrorCode = @intCast(c.RGFW_errClipboard);
    pub const failedFuncLoad: ErrorCode = @intCast(c.RGFW_errFailedFuncLoad);
    pub const buffer: ErrorCode = @intCast(c.RGFW_errBuffer);
    pub const metal: ErrorCode = @intCast(c.RGFW_errMetal);
    pub const platform: ErrorCode = @intCast(c.RGFW_errPlatform);
    pub const eventQueue: ErrorCode = @intCast(c.RGFW_errEventQueue);
    pub const noInit: ErrorCode = @intCast(c.RGFW_errNoInit);
    pub const infoWindow: ErrorCode = @intCast(c.RGFW_infoWindow);
    pub const infoBuffer: ErrorCode = @intCast(c.RGFW_infoBuffer);
    pub const infoGlobal: ErrorCode = @intCast(c.RGFW_infoGlobal);
    pub const infoOpenGl: ErrorCode = @intCast(c.RGFW_infoOpenGL);
    pub const warningWayland: ErrorCode = @intCast(c.RGFW_warningWayland);
    pub const warningOpenGl: ErrorCode = @intCast(c.RGFW_warningOpenGL);
};

pub const glReleaseBehavior = struct {
    pub const flush: GlReleaseBehavior = @intCast(c.RGFW_glReleaseFlush);
    pub const none: GlReleaseBehavior = @intCast(c.RGFW_glReleaseNone);
};

pub const glProfile = struct {
    pub const core: GlProfile = @intCast(c.RGFW_glCore);
    pub const forwardCompatibility: GlProfile = @intCast(c.RGFW_glForwardCompatibility);
    pub const compatibility: GlProfile = @intCast(c.RGFW_glCompatibility);
    pub const es: GlProfile = @intCast(c.RGFW_glES);
    pub const web: GlProfile = @intCast(c.RGFW_glWeb);
};

pub const glRenderer = struct {
    pub const accelerated: GlRenderer = @intCast(c.RGFW_glAccelerated);
    pub const software: GlRenderer = @intCast(c.RGFW_glSoftware);
};

fn boolToC(value: bool) c.RGFW_bool {
    return if (value) c.RGFW_TRUE else c.RGFW_FALSE;
}

fn boolFromC(value: c.RGFW_bool) bool {
    return value != c.RGFW_FALSE;
}

fn ptrCast(comptime T: type, ptr: anytype) T {
    return @ptrCast(ptr);
}

fn cWindow(window_ptr: *Window) *c.RGFW_window {
    return ptrCast(*c.RGFW_window, window_ptr);
}

fn zigWindow(window_ptr: ?*c.RGFW_window) ?*Window {
    return if (window_ptr) |ptr| ptrCast(*Window, ptr) else null;
}

fn cMonitor(monitor_ptr: *Monitor) *c.RGFW_monitor {
    return ptrCast(*c.RGFW_monitor, monitor_ptr);
}

fn zigMonitor(monitor_ptr: ?*c.RGFW_monitor) ?*Monitor {
    return if (monitor_ptr) |ptr| ptrCast(*Monitor, ptr) else null;
}

fn cMonitorMode(mode: *MonitorMode) *c.RGFW_monitorMode {
    return ptrCast(*c.RGFW_monitorMode, mode);
}

fn cMonitorNode(node: *MonitorNode) *c.RGFW_monitorNode {
    return ptrCast(*c.RGFW_monitorNode, node);
}

fn zigMonitorNode(node: ?*c.RGFW_monitorNode) ?*MonitorNode {
    return if (node) |ptr| ptrCast(*MonitorNode, ptr) else null;
}

fn cSurface(surface_ptr: *Surface) *c.RGFW_surface {
    return ptrCast(*c.RGFW_surface, surface_ptr);
}

fn zigSurface(surface_ptr: ?*c.RGFW_surface) ?*Surface {
    return if (surface_ptr) |ptr| ptrCast(*Surface, ptr) else null;
}

fn cMouse(mouse_ptr: *Mouse) *c.RGFW_mouse {
    return ptrCast(*c.RGFW_mouse, mouse_ptr);
}

fn zigMouse(mouse_ptr: ?*c.RGFW_mouse) ?*Mouse {
    return if (mouse_ptr) |ptr| ptrCast(*Mouse, ptr) else null;
}

fn optionalCString(text: ?[:0]const u8) [*c]const u8 {
    return if (text) |s| s.ptr else null;
}

fn cInfo(info: *Info) *c.RGFW_info {
    return ptrCast(*c.RGFW_info, info);
}

fn zigInfo(info: ?*c.RGFW_info) ?*Info {
    return if (info) |ptr| ptrCast(*Info, ptr) else null;
}

fn cGlContext(ctx: *GlContext) *c.RGFW_glContext {
    return ptrCast(*c.RGFW_glContext, ctx);
}

fn zigGlContext(ctx: ?*c.RGFW_glContext) ?*GlContext {
    return if (ctx) |ptr| ptrCast(*GlContext, ptr) else null;
}

fn cEglContext(ctx: *EglContext) *c.RGFW_eglContext {
    return ptrCast(*c.RGFW_eglContext, ctx);
}

fn zigEglContext(ctx: ?*c.RGFW_eglContext) ?*EglContext {
    return if (ctx) |ptr| ptrCast(*EglContext, ptr) else null;
}

pub fn alloc(size: usize) ?*anyopaque {
    return c.RGFW_alloc(size);
}

pub fn free(ptr: ?*anyopaque) void {
    c.RGFW_free(ptr);
}

pub fn init(class_name: ?[:0]const u8, flags: InitFlags) i32 {
    return @intCast(c.RGFW_init(optionalCString(class_name), @intCast(flags)));
}

pub fn initPtr(class_name: ?[:0]const u8, flags: InitFlags, info: *Info) i32 {
    return @intCast(c.RGFW_init_ptr(optionalCString(class_name), @intCast(flags), cInfo(info)));
}

pub fn deinit() void {
    c.RGFW_deinit();
}

pub fn deinitPtr(info: *Info) void {
    c.RGFW_deinit_ptr(cInfo(info));
}

pub fn setInfo(info: *Info) void {
    c.RGFW_setInfo(cInfo(info));
}

pub fn getInfo() ?*Info {
    return zigInfo(c.RGFW_getInfo());
}

pub fn sizeofInfo() usize {
    return c.RGFW_sizeofInfo();
}

pub fn sizeofWindow() usize {
    return c.RGFW_sizeofWindow();
}

pub fn sizeofWindowSrc() usize {
    return c.RGFW_sizeofWindowSrc();
}

pub fn usingWayland() bool {
    return boolFromC(c.RGFW_usingWayland());
}

pub fn getLayerOsx() ?*anyopaque {
    if (!@hasDecl(c, "RGFW_getLayer_OSX")) return null;
    return c.RGFW_getLayer_OSX();
}

pub fn getDisplayX11() ?*anyopaque {
    if (!@hasDecl(c, "RGFW_getDisplay_X11")) return null;
    return c.RGFW_getDisplay_X11();
}

pub fn getDisplayWayland() ?*WlDisplay {
    if (!@hasDecl(c, "RGFW_getDisplay_Wayland")) return null;
    const display = c.RGFW_getDisplay_Wayland();
    return if (display == null) null else ptrCast(*WlDisplay, display);
}

pub fn moveToMacOSResourceDir() void {
    c.RGFW_moveToMacOSResourceDir();
}

pub fn copyImageData(dest: []u8, size: Size, dest_format: Format, src: []u8, src_format: Format, func: ConvertImageDataFunc) void {
    c.RGFW_copyImageData(dest.ptr, size.w, size.h, @intCast(dest_format), src.ptr, @intCast(src_format), func);
}

pub fn copyImageData64(dest: []u8, size: Size, dest_format: Format, src: []u8, src_format: Format, is_64_bit: bool, func: ConvertImageDataFunc) Error!void {
    if (!@hasDecl(c, "RGFW_copyImageData64")) return Error.MissingDeclaration;
    c.RGFW_copyImageData64(dest.ptr, size.w, size.h, @intCast(dest_format), src.ptr, @intCast(src_format), boolToC(is_64_bit), func);
}

pub fn convertImageData64(dest: []u8, src: []u8, src_layout: *const ColorLayout, dest_layout: *const ColorLayout, count: usize, is_64_bit: bool) Error!void {
    if (!@hasDecl(c, "RGFW_convertImageData64")) return Error.MissingDeclaration;
    c.RGFW_convertImageData64(dest.ptr, src.ptr, ptrCast(*const c.RGFW_colorLayout, src_layout), ptrCast(*const c.RGFW_colorLayout, dest_layout), count, boolToC(is_64_bit));
}

pub fn sizeofNativeImage() usize {
    return c.RGFW_sizeofNativeImage();
}

pub fn setRawMouseMode(state: bool) void {
    c.RGFW_setRawMouseMode(boolToC(state));
}

pub fn setBuildDnd(allow: bool) void {
    c.RGFW_setBuildDND(boolToC(allow));
}

pub fn waitForEvent(wait_ms: i32) void {
    c.RGFW_waitForEvent(@intCast(wait_ms));
}

pub fn pollEvents() void {
    c.RGFW_pollEvents();
}

pub fn stopCheckEvents() void {
    c.RGFW_stopCheckEvents();
}

pub fn checkEvent(event: *Event) bool {
    return boolFromC(c.RGFW_checkEvent(ptrCast(*c.RGFW_event, event)));
}

pub fn checkQueuedEvent(event: *Event) bool {
    return boolFromC(c.RGFW_checkQueuedEvent(ptrCast(*c.RGFW_event, event)));
}

pub fn setQueueEvents(queue: bool) void {
    c.RGFW_setQueueEvents(boolToC(queue));
}

pub fn setEventCallback(event_type: EventType, func: GenericFunc) GenericFunc {
    return c.RGFW_setEventCallback(@intCast(event_type), func);
}

pub fn setDualEventCallback(event_type: EventType, func: GenericFunc, first: *GenericFunc, second: *GenericFunc) void {
    c.RGFW_setDualEventCallback(@intCast(event_type), func, first, second);
}

pub fn setAllEventCallbacks(func: GenericFunc, callback_set: *Callbacks) void {
    c.RGFW_setAllEventCallbacks(func, callback_set);
}

pub fn createWindow(name: [:0]const u8, pos: Position, size: Size, flags: WindowFlags) ?*Window {
    return zigWindow(c.RGFW_createWindow(name.ptr, pos.x, pos.y, size.w, size.h, @intCast(flags)));
}

pub fn createWindowPtr(name: [:0]const u8, pos: Position, size: Size, flags: WindowFlags, win: *Window) ?*Window {
    return zigWindow(c.RGFW_createWindowPtr(name.ptr, pos.x, pos.y, size.w, size.h, @intCast(flags), cWindow(win)));
}

pub fn getGlobalMouse() ?Position {
    var x: i32 = 0;
    var y: i32 = 0;
    if (!boolFromC(c.RGFW_getGlobalMouse(&x, &y))) return null;
    return .{ .x = x, .y = y };
}

pub fn getMouseScroll() MouseVector {
    var x: f32 = 0;
    var y: f32 = 0;
    c.RGFW_getMouseScroll(&x, &y);
    return .{ .x = x, .y = y };
}

pub fn getMouseVector() MouseVector {
    var x: f32 = 0;
    var y: f32 = 0;
    c.RGFW_getMouseVector(&x, &y);
    return .{ .x = x, .y = y };
}

pub fn isKeyPressed(key_code: Key) bool {
    return boolFromC(c.RGFW_isKeyPressed(@intCast(key_code)));
}

pub fn isKeyReleased(key_code: Key) bool {
    return boolFromC(c.RGFW_isKeyReleased(@intCast(key_code)));
}

pub fn isKeyDown(key_code: Key) bool {
    return boolFromC(c.RGFW_isKeyDown(@intCast(key_code)));
}

pub fn isMousePressed(button: MouseButton) bool {
    return boolFromC(c.RGFW_isMousePressed(@intCast(button)));
}

pub fn isMouseReleased(button: MouseButton) bool {
    return boolFromC(c.RGFW_isMouseReleased(@intCast(button)));
}

pub fn isMouseDown(button: MouseButton) bool {
    return boolFromC(c.RGFW_isMouseDown(@intCast(button)));
}

pub fn setRootWindow(win: ?*Window) void {
    c.RGFW_setRootWindow(if (win) |w| cWindow(w) else null);
}

pub fn getRootWindow() ?*Window {
    return zigWindow(c.RGFW_getRootWindow());
}

pub fn apiKeyToRgfw(keycode: u32) Key {
    return @intCast(c.RGFW_apiKeyToRGFW(@intCast(keycode)));
}

pub fn rgfwToApiKey(keycode: Key) u32 {
    return @intCast(c.RGFW_rgfwToApiKey(@intCast(keycode)));
}

pub fn physicalToMappedKey(keycode: Key) Key {
    return @intCast(c.RGFW_physicalToMappedKey(@intCast(keycode)));
}

pub fn isLatin(text: []const u8) Error!bool {
    if (!@hasDecl(c, "RGFW_isLatin")) return Error.MissingDeclaration;
    return boolFromC(c.RGFW_isLatin(text.ptr, text.len));
}

pub fn decodeUtf8(text: [:0]const u8, starting_index: *usize) Error!u32 {
    if (!@hasDecl(c, "RGFW_decodeUTF8")) return Error.MissingDeclaration;
    return @intCast(c.RGFW_decodeUTF8(text.ptr, starting_index));
}

pub fn extensionSupportedStr(extensions: [:0]const u8, extension: []const u8) Error!bool {
    if (!@hasDecl(c, "RGFW_extensionSupportedStr")) return Error.MissingDeclaration;
    return boolFromC(c.RGFW_extensionSupportedStr(extensions.ptr, extension.ptr, extension.len));
}

pub fn extensionSupportedBase(extension: []const u8, get_proc_address: ProcLoader) Error!bool {
    if (!@hasDecl(c, "RGFW_extensionSupported_base")) return Error.MissingDeclaration;
    return boolFromC(c.RGFW_extensionSupported_base(extension.ptr, extension.len, @ptrCast(get_proc_address)));
}

pub const window = struct {
    pub fn createSurface(win: *Window, image: Image) ?*Surface {
        return zigSurface(c.RGFW_window_createSurface(cWindow(win), image.data.ptr, image.w, image.h, @intCast(image.format)));
    }

    pub fn createSurfacePtr(win: *Window, image: Image, surface_ptr: *Surface) bool {
        return boolFromC(c.RGFW_window_createSurfacePtr(cWindow(win), image.data.ptr, image.w, image.h, @intCast(image.format), cSurface(surface_ptr)));
    }

    pub fn close(win: *Window) void {
        c.RGFW_window_close(cWindow(win));
    }

    pub fn closePtr(win: *Window) void {
        c.RGFW_window_closePtr(cWindow(win));
    }

    pub fn shouldClose(win: *Window) bool {
        return boolFromC(c.RGFW_window_shouldClose(cWindow(win)));
    }

    pub fn setShouldClose(win: *Window, should_close: bool) void {
        c.RGFW_window_setShouldClose(cWindow(win), boolToC(should_close));
    }

    pub fn getExitKey(win: *Window) Key {
        return @intCast(c.RGFW_window_getExitKey(cWindow(win)));
    }

    pub fn setExitKey(win: *Window, key_code: Key) void {
        c.RGFW_window_setExitKey(cWindow(win), @intCast(key_code));
    }

    pub fn getPosition(win: *Window) ?Position {
        var x: i32 = 0;
        var y: i32 = 0;
        if (!boolFromC(c.RGFW_window_getPosition(cWindow(win), &x, &y))) return null;
        return .{ .x = x, .y = y };
    }

    pub fn getSize(win: *Window) ?Size {
        var w: i32 = 0;
        var h: i32 = 0;
        if (!boolFromC(c.RGFW_window_getSize(cWindow(win), &w, &h))) return null;
        return .{ .w = w, .h = h };
    }

    pub fn getSizeInPixels(win: *Window) ?Size {
        var w: i32 = 0;
        var h: i32 = 0;
        if (!boolFromC(c.RGFW_window_getSizeInPixels(cWindow(win), &w, &h))) return null;
        return .{ .w = w, .h = h };
    }

    pub fn fetchSize(win: *Window) ?Size {
        var w: i32 = 0;
        var h: i32 = 0;
        if (!boolFromC(c.RGFW_window_fetchSize(cWindow(win), &w, &h))) return null;
        return .{ .w = w, .h = h };
    }

    pub fn getFlags(win: *Window) WindowFlags {
        return @intCast(c.RGFW_window_getFlags(cWindow(win)));
    }

    pub fn setFlags(win: *Window, flags: WindowFlags) void {
        c.RGFW_window_setFlags(cWindow(win), @intCast(flags));
    }

    pub fn setEnabledEvents(win: *Window, events: EventFlag) void {
        c.RGFW_window_setEnabledEvents(cWindow(win), @intCast(events));
    }

    pub fn getEnabledEvents(win: *Window) EventFlag {
        return @intCast(c.RGFW_window_getEnabledEvents(cWindow(win)));
    }

    pub fn setDisabledEvents(win: *Window, events: EventFlag) void {
        c.RGFW_window_setDisabledEvents(cWindow(win), @intCast(events));
    }

    pub fn setEventState(win: *Window, event: EventFlag, state: bool) void {
        c.RGFW_window_setEventState(cWindow(win), @intCast(event), boolToC(state));
    }

    pub fn getUserPtr(win: *Window) ?*anyopaque {
        return c.RGFW_window_getUserPtr(cWindow(win));
    }

    pub fn setUserPtr(win: *Window, ptr: ?*anyopaque) void {
        c.RGFW_window_setUserPtr(cWindow(win), ptr);
    }

    pub fn getSrc(win: *Window) ?*WindowSrc {
        const src = c.RGFW_window_getSrc(cWindow(win));
        return if (src == null) null else ptrCast(*WindowSrc, src);
    }

    pub fn setLayerOsx(win: *Window, layer: ?*anyopaque) Error!void {
        if (!@hasDecl(c, "RGFW_window_setLayer_OSX")) return Error.MissingDeclaration;
        c.RGFW_window_setLayer_OSX(cWindow(win), layer);
    }

    pub fn getViewOsx(win: *Window) Error!?*anyopaque {
        if (!@hasDecl(c, "RGFW_window_getView_OSX")) return Error.MissingDeclaration;
        return c.RGFW_window_getView_OSX(cWindow(win));
    }

    pub fn getWindowOsx(win: *Window) Error!?*anyopaque {
        if (!@hasDecl(c, "RGFW_window_getWindow_OSX")) return Error.MissingDeclaration;
        return c.RGFW_window_getWindow_OSX(cWindow(win));
    }

    pub fn getHwnd(win: *Window) Error!?*anyopaque {
        if (!@hasDecl(c, "RGFW_window_getHWND")) return Error.MissingDeclaration;
        return c.RGFW_window_getHWND(cWindow(win));
    }

    pub fn getHdc(win: *Window) Error!?*anyopaque {
        if (!@hasDecl(c, "RGFW_window_getHDC")) return Error.MissingDeclaration;
        return c.RGFW_window_getHDC(cWindow(win));
    }

    pub fn getWindowX11(win: *Window) Error!u64 {
        if (!@hasDecl(c, "RGFW_window_getWindow_X11")) return Error.MissingDeclaration;
        return @intCast(c.RGFW_window_getWindow_X11(cWindow(win)));
    }

    pub fn getWindowWayland(win: *Window) Error!?*WlSurface {
        if (!@hasDecl(c, "RGFW_window_getWindow_Wayland")) return Error.MissingDeclaration;
        const surface_ptr = c.RGFW_window_getWindow_Wayland(cWindow(win));
        return if (surface_ptr == null) null else ptrCast(*WlSurface, surface_ptr);
    }

    pub fn checkEvent(win: *Window, event: *Event) bool {
        return boolFromC(c.RGFW_window_checkEvent(cWindow(win), ptrCast(*c.RGFW_event, event)));
    }

    pub fn checkQueuedEvent(win: *Window, event: *Event) bool {
        return boolFromC(c.RGFW_window_checkQueuedEvent(cWindow(win), ptrCast(*c.RGFW_event, event)));
    }

    pub fn isKeyPressed(win: *Window, key_code: Key) bool {
        return boolFromC(c.RGFW_window_isKeyPressed(cWindow(win), @intCast(key_code)));
    }

    pub fn isKeyDown(win: *Window, key_code: Key) bool {
        return boolFromC(c.RGFW_window_isKeyDown(cWindow(win), @intCast(key_code)));
    }

    pub fn isKeyReleased(win: *Window, key_code: Key) bool {
        return boolFromC(c.RGFW_window_isKeyReleased(cWindow(win), @intCast(key_code)));
    }

    pub fn isMousePressed(win: *Window, button: MouseButton) bool {
        return boolFromC(c.RGFW_window_isMousePressed(cWindow(win), @intCast(button)));
    }

    pub fn isMouseDown(win: *Window, button: MouseButton) bool {
        return boolFromC(c.RGFW_window_isMouseDown(cWindow(win), @intCast(button)));
    }

    pub fn isMouseReleased(win: *Window, button: MouseButton) bool {
        return boolFromC(c.RGFW_window_isMouseReleased(cWindow(win), @intCast(button)));
    }

    pub fn didMouseLeave(win: *Window) bool {
        return boolFromC(c.RGFW_window_didMouseLeave(cWindow(win)));
    }

    pub fn didMouseEnter(win: *Window) bool {
        return boolFromC(c.RGFW_window_didMouseEnter(cWindow(win)));
    }

    pub fn isMouseInside(win: *Window) bool {
        return boolFromC(c.RGFW_window_isMouseInside(cWindow(win)));
    }

    pub fn isDataDragging(win: *Window) bool {
        return boolFromC(c.RGFW_window_isDataDragging(cWindow(win)));
    }

    pub fn getDataDrag(win: *Window) ?Position {
        var x: i32 = 0;
        var y: i32 = 0;
        if (!boolFromC(c.RGFW_window_getDataDrag(cWindow(win), &x, &y))) return null;
        return .{ .x = x, .y = y };
    }

    pub fn didDataDrop(win: *Window) bool {
        return boolFromC(c.RGFW_window_didDataDrop(cWindow(win)));
    }

    pub fn getDataDrop(win: *Window) ?*DataDropNode {
        const node = c.RGFW_window_getDataDrop(cWindow(win));
        return if (node == null) null else ptrCast(*DataDropNode, node);
    }

    pub fn move(win: *Window, pos: Position) void {
        c.RGFW_window_move(cWindow(win), pos.x, pos.y);
    }

    pub fn resize(win: *Window, size: Size) void {
        c.RGFW_window_resize(cWindow(win), size.w, size.h);
    }

    pub fn moveToMonitor(win: *Window, mon: *Monitor) void {
        c.RGFW_window_moveToMonitor(cWindow(win), cMonitor(mon));
    }

    pub fn setAspectRatio(win: *Window, size: Size) void {
        c.RGFW_window_setAspectRatio(cWindow(win), size.w, size.h);
    }

    pub fn setMinSize(win: *Window, size: Size) void {
        c.RGFW_window_setMinSize(cWindow(win), size.w, size.h);
    }

    pub fn setMaxSize(win: *Window, size: Size) void {
        c.RGFW_window_setMaxSize(cWindow(win), size.w, size.h);
    }

    pub fn focus(win: *Window) void {
        c.RGFW_window_focus(cWindow(win));
    }

    pub fn isInFocus(win: *Window) bool {
        return boolFromC(c.RGFW_window_isInFocus(cWindow(win)));
    }

    pub fn raise(win: *Window) void {
        c.RGFW_window_raise(cWindow(win));
    }

    pub fn maximize(win: *Window) void {
        c.RGFW_window_maximize(cWindow(win));
    }

    pub fn center(win: *Window) void {
        c.RGFW_window_center(cWindow(win));
    }

    pub fn minimize(win: *Window) void {
        c.RGFW_window_minimize(cWindow(win));
    }

    pub fn restore(win: *Window) void {
        c.RGFW_window_restore(cWindow(win));
    }

    pub fn hide(win: *Window) void {
        c.RGFW_window_hide(cWindow(win));
    }

    pub fn show(win: *Window) void {
        c.RGFW_window_show(cWindow(win));
    }

    pub fn flash(win: *Window, request: FlashRequest) void {
        c.RGFW_window_flash(cWindow(win), @intCast(request));
    }

    pub fn setFullscreen(win: *Window, fullscreen: bool) void {
        c.RGFW_window_setFullscreen(cWindow(win), boolToC(fullscreen));
    }

    pub fn setFloating(win: *Window, floating: bool) void {
        c.RGFW_window_setFloating(cWindow(win), boolToC(floating));
    }

    pub fn setOpacity(win: *Window, opacity: u8) void {
        c.RGFW_window_setOpacity(cWindow(win), opacity);
    }

    pub fn setBorder(win: *Window, border: bool) void {
        c.RGFW_window_setBorder(cWindow(win), boolToC(border));
    }

    pub fn borderless(win: *Window) bool {
        return boolFromC(c.RGFW_window_borderless(cWindow(win)));
    }

    pub fn setDnd(win: *Window, allow: bool) void {
        c.RGFW_window_setDND(cWindow(win), boolToC(allow));
    }

    pub fn allowsDnd(win: *Window) bool {
        return boolFromC(c.RGFW_window_allowsDND(cWindow(win)));
    }

    pub fn setMousePassthrough(win: *Window, passthrough: bool) Error!void {
        if (!@hasDecl(c, "RGFW_window_setMousePassthrough")) return Error.MissingDeclaration;
        c.RGFW_window_setMousePassthrough(cWindow(win), boolToC(passthrough));
    }

    pub fn setName(win: *Window, name: [:0]const u8) void {
        c.RGFW_window_setName(cWindow(win), name.ptr);
    }

    pub fn setIcon(win: *Window, image: Image) bool {
        return boolFromC(c.RGFW_window_setIcon(cWindow(win), image.data.ptr, image.w, image.h, @intCast(image.format)));
    }

    pub fn setIconEx(win: *Window, image: Image, icon_type: Icon) bool {
        return boolFromC(c.RGFW_window_setIconEx(cWindow(win), image.data.ptr, image.w, image.h, @intCast(image.format), @intCast(icon_type)));
    }

    pub fn showMouse(win: *Window, visible: bool) void {
        c.RGFW_window_showMouse(cWindow(win), boolToC(visible));
    }

    pub fn isMouseHidden(win: *Window) bool {
        return boolFromC(c.RGFW_window_isMouseHidden(cWindow(win)));
    }

    pub fn moveMouse(win: *Window, pos: Position) void {
        c.RGFW_window_moveMouse(cWindow(win), pos.x, pos.y);
    }

    pub fn getMouse(win: *Window) ?Position {
        var x: i32 = 0;
        var y: i32 = 0;
        if (!boolFromC(c.RGFW_window_getMouse(cWindow(win), &x, &y))) return null;
        return .{ .x = x, .y = y };
    }

    pub fn isFullscreen(win: *Window) bool {
        return boolFromC(c.RGFW_window_isFullscreen(cWindow(win)));
    }

    pub fn isHidden(win: *Window) bool {
        return boolFromC(c.RGFW_window_isHidden(cWindow(win)));
    }

    pub fn isMinimized(win: *Window) bool {
        return boolFromC(c.RGFW_window_isMinimized(cWindow(win)));
    }

    pub fn isMaximized(win: *Window) bool {
        return boolFromC(c.RGFW_window_isMaximized(cWindow(win)));
    }

    pub fn isFloating(win: *Window) bool {
        return boolFromC(c.RGFW_window_isFloating(cWindow(win)));
    }

    pub fn scaleToMonitor(win: *Window) void {
        c.RGFW_window_scaleToMonitor(cWindow(win));
    }

    pub fn getMonitor(win: *Window) ?*Monitor {
        return zigMonitor(c.RGFW_window_getMonitor(cWindow(win)));
    }
};

pub const monitor = struct {
    pub fn poll() void {
        c.RGFW_pollMonitors();
    }

    pub fn freeAll() void {
        c.RGFW_freeMonitors();
    }

    pub fn getPrimary() ?*Monitor {
        return zigMonitor(c.RGFW_getPrimaryMonitor());
    }

    pub fn getMonitors() ?[]?*Monitor {
        var len: usize = 0;
        const monitors = c.RGFW_getMonitors(&len);
        if (monitors == null) return null;
        return @as([*]?*Monitor, @ptrCast(monitors))[0..len];
    }

    pub fn getAll(buffer: []?*Monitor) usize {
        var len: usize = 0;
        const ok = c.RGFW_getMonitorsPtr(buffer.len, @ptrCast(buffer.ptr), &len);
        if (!boolFromC(ok)) return 0;
        return len;
    }

    pub fn getModes(mon: *Monitor) ?[]MonitorMode {
        var count: usize = 0;
        const modes = c.RGFW_monitor_getModes(cMonitor(mon), &count);
        if (modes == null) return null;
        return @as([*]MonitorMode, @ptrCast(modes))[0..count];
    }

    pub fn getModesPtr(mon: *Monitor) ?[]MonitorMode {
        var modes: [*c]c.RGFW_monitorMode = null;
        const count = c.RGFW_monitor_getModesPtr(cMonitor(mon), &modes);
        if (modes == null) return null;
        return @as([*]MonitorMode, @ptrCast(modes))[0..count];
    }

    pub fn freeModes(modes: []MonitorMode) void {
        c.RGFW_freeModes(@ptrCast(modes.ptr));
    }

    pub fn findClosestMode(mon: *Monitor, mode: *MonitorMode) ?MonitorMode {
        var closest: c.RGFW_monitorMode = undefined;
        if (!boolFromC(c.RGFW_monitor_findClosestMode(cMonitor(mon), ptrCast(*c.RGFW_monitorMode, mode), &closest))) return null;
        return @bitCast(closest);
    }

    pub fn getGammaRamp(mon: *Monitor) ?*GammaRamp {
        const ramp = c.RGFW_monitor_getGammaRamp(cMonitor(mon));
        return if (ramp == null) null else ptrCast(*GammaRamp, ramp);
    }

    pub fn freeGammaRamp(ramp: *GammaRamp) void {
        c.RGFW_freeGammaRamp(ptrCast(*c.RGFW_gammaRamp, ramp));
    }

    pub fn getGammaRampPtr(mon: *Monitor, ramp: *GammaRamp) usize {
        return c.RGFW_monitor_getGammaRampPtr(cMonitor(mon), ptrCast(*c.RGFW_gammaRamp, ramp));
    }

    pub fn setGammaRamp(mon: *Monitor, ramp: *GammaRamp) bool {
        return boolFromC(c.RGFW_monitor_setGammaRamp(cMonitor(mon), ptrCast(*c.RGFW_gammaRamp, ramp)));
    }

    pub fn setGamma(mon: *Monitor, gamma: f32) bool {
        return boolFromC(c.RGFW_monitor_setGamma(cMonitor(mon), gamma));
    }

    pub fn setGammaPtr(mon: *Monitor, gamma: f32, ptr: []u16) bool {
        return boolFromC(c.RGFW_monitor_setGammaPtr(cMonitor(mon), gamma, ptr.ptr, ptr.len));
    }

    pub fn getPosition(mon: *Monitor) ?Position {
        var x: i32 = 0;
        var y: i32 = 0;
        if (!boolFromC(c.RGFW_monitor_getPosition(cMonitor(mon), &x, &y))) return null;
        return .{ .x = x, .y = y };
    }

    pub fn getWorkarea(mon: *Monitor) ?Rect {
        var x: i32 = 0;
        var y: i32 = 0;
        var w: i32 = 0;
        var h: i32 = 0;
        if (!boolFromC(c.RGFW_monitor_getWorkarea(cMonitor(mon), &x, &y, &w, &h))) return null;
        return .{ .x = x, .y = y, .w = w, .h = h };
    }

    pub fn getName(mon: *Monitor) ?[*:0]const u8 {
        const name = c.RGFW_monitor_getName(cMonitor(mon));
        return if (name == null) null else @ptrCast(name);
    }

    pub fn getScale(mon: *Monitor) ?Scale {
        var x: f32 = 0;
        var y: f32 = 0;
        if (!boolFromC(c.RGFW_monitor_getScale(cMonitor(mon), &x, &y))) return null;
        return .{ .x = x, .y = y };
    }

    pub fn getPhysicalSize(mon: *Monitor) ?Scale {
        var w: f32 = 0;
        var h: f32 = 0;
        if (!boolFromC(c.RGFW_monitor_getPhysicalSize(cMonitor(mon), &w, &h))) return null;
        return .{ .x = w, .y = h };
    }

    pub fn setUserPtr(mon: *Monitor, user_ptr: ?*anyopaque) void {
        c.RGFW_monitor_setUserPtr(cMonitor(mon), user_ptr);
    }

    pub fn getUserPtr(mon: *Monitor) ?*anyopaque {
        return c.RGFW_monitor_getUserPtr(cMonitor(mon));
    }

    pub fn getMode(mon: *Monitor) ?MonitorMode {
        var mode: c.RGFW_monitorMode = undefined;
        if (!boolFromC(c.RGFW_monitor_getMode(cMonitor(mon), &mode))) return null;
        return @bitCast(mode);
    }

    pub fn requestMode(mon: *Monitor, mode: *MonitorMode, request: ModeRequest) bool {
        return boolFromC(c.RGFW_monitor_requestMode(cMonitor(mon), ptrCast(*c.RGFW_monitorMode, mode), @intCast(request)));
    }

    pub fn setMode(mon: *Monitor, mode: *MonitorMode) bool {
        return boolFromC(c.RGFW_monitor_setMode(cMonitor(mon), ptrCast(*c.RGFW_monitorMode, mode)));
    }

    pub fn modeCompare(a: *MonitorMode, b: *MonitorMode, request: ModeRequest) bool {
        return boolFromC(c.RGFW_monitorModeCompare(ptrCast(*c.RGFW_monitorMode, a), ptrCast(*c.RGFW_monitorMode, b), @intCast(request)));
    }

    pub fn scaleToWindow(mon: *Monitor, win: *Window) bool {
        return boolFromC(c.RGFW_monitor_scaleToWindow(cMonitor(mon), cWindow(win)));
    }
};

pub const surface = struct {
    pub fn create(image: Image) ?*Surface {
        return zigSurface(c.RGFW_createSurface(image.data.ptr, image.w, image.h, @intCast(image.format)));
    }

    pub fn createPtr(image: Image, surface_ptr: *Surface) bool {
        return boolFromC(c.RGFW_createSurfacePtr(image.data.ptr, image.w, image.h, @intCast(image.format), cSurface(surface_ptr)));
    }

    pub fn getNativeImage(surface_ptr: *Surface) ?*NativeImage {
        const image = c.RGFW_surface_getNativeImage(cSurface(surface_ptr));
        return if (image == null) null else ptrCast(*NativeImage, image);
    }

    pub fn setConvertFunc(surface_ptr: *Surface, func: ConvertImageDataFunc) void {
        c.RGFW_surface_setConvertFunc(cSurface(surface_ptr), func);
    }

    pub fn free(surface_ptr: *Surface) void {
        c.RGFW_surface_free(cSurface(surface_ptr));
    }

    pub fn freePtr(surface_ptr: *Surface) void {
        c.RGFW_surface_freePtr(cSurface(surface_ptr));
    }

    pub fn sizeof() usize {
        return c.RGFW_sizeofSurface();
    }

    pub fn nativeFormat() Format {
        return @intCast(c.RGFW_nativeFormat());
    }

    pub fn blit(win: *Window, surface_ptr: *Surface) void {
        c.RGFW_window_blitSurface(cWindow(win), cSurface(surface_ptr));
    }
};

pub const eventQueue = struct {
    pub fn push(event: *const Event) void {
        c.RGFW_eventQueuePush(ptrCast(*const c.RGFW_event, event));
    }

    pub fn pushAndCall(event: *const Event) void {
        c.RGFW_eventQueuePushAndCall(ptrCast(*const c.RGFW_event, event));
    }

    pub fn flush() void {
        c.RGFW_eventQueueFlush();
    }

    pub fn pop() ?*Event {
        const event = c.RGFW_eventQueuePop();
        return if (event == null) null else ptrCast(*Event, event);
    }

    pub fn popWindow(win: *Window) ?*Event {
        const event = c.RGFW_window_eventQueuePop(cWindow(win));
        return if (event == null) null else ptrCast(*Event, event);
    }
};

pub const debug = struct {
    pub fn setCallback(func: DebugFunc) DebugFunc {
        return c.RGFW_setDebugCallback(func);
    }

    pub fn callback(debug_type: DebugType, code: ErrorCode, msg: [:0]const u8) void {
        c.RGFW_debugCallback(@intCast(debug_type), @intCast(code), msg.ptr);
    }
};

pub const mouse = struct {
    pub fn create(image: Image) ?*Mouse {
        return zigMouse(c.RGFW_createMouse(image.data.ptr, image.w, image.h, @intCast(image.format)));
    }

    pub fn createStandard(icon_id: MouseIcon) ?*Mouse {
        return zigMouse(c.RGFW_createMouseStandard(@intCast(icon_id)));
    }

    pub fn free(mouse_ptr: *Mouse) void {
        c.RGFW_freeMouse(cMouse(mouse_ptr));
    }

    pub fn set(win: *Window, mouse_ptr: *Mouse) bool {
        return boolFromC(c.RGFW_window_setMouse(cWindow(win), cMouse(mouse_ptr)));
    }

    pub fn setStandard(win: *Window, icon_id: MouseIcon) bool {
        return boolFromC(c.RGFW_window_setMouseStandard(cWindow(win), @intCast(icon_id)));
    }

    pub fn setDefault(win: *Window) bool {
        return boolFromC(c.RGFW_window_setMouseDefault(cWindow(win)));
    }

    pub fn setRawMode(win: *Window, state: bool) void {
        c.RGFW_window_setRawMouseMode(cWindow(win), boolToC(state));
    }

    pub fn capture(win: *Window, state: bool) void {
        c.RGFW_window_captureMouse(cWindow(win), boolToC(state));
    }

    pub fn captureRaw(win: *Window, state: bool) void {
        c.RGFW_window_captureRawMouse(cWindow(win), boolToC(state));
    }

    pub fn isRawMode(win: *Window) bool {
        return boolFromC(c.RGFW_window_isRawMouseMode(cWindow(win)));
    }

    pub fn isCaptured(win: *Window) bool {
        return boolFromC(c.RGFW_window_isCaptured(cWindow(win)));
    }
};

pub const clipboard = struct {
    pub fn read() ?*const DataTransfer {
        const data = c.RGFW_readClipboard();
        return if (data == null) null else ptrCast(*const DataTransfer, data);
    }

    pub fn readPtr(buffer: []u8, data: *DataTransfer) bool {
        return boolFromC(c.RGFW_readClipboardPtr(buffer.ptr, buffer.len, ptrCast(*c.RGFW_dataTransfer, data)));
    }

    pub fn write(data: *const DataTransfer) bool {
        return boolFromC(c.RGFW_writeClipboard(ptrCast(*const c.RGFW_dataTransfer, data)));
    }
};

pub const opengl = struct {
    pub fn setGlobalHints(hints: *GlHints) Error!void {
        if (!@hasDecl(c, "RGFW_setGlobalHints_OpenGL")) return Error.MissingDeclaration;
        c.RGFW_setGlobalHints_OpenGL(ptrCast(*c.RGFW_glHints, hints));
    }

    pub fn resetGlobalHints() Error!void {
        if (!@hasDecl(c, "RGFW_resetGlobalHints_OpenGL")) return Error.MissingDeclaration;
        c.RGFW_resetGlobalHints_OpenGL();
    }

    pub fn getGlobalHints() Error!?*GlHints {
        if (!@hasDecl(c, "RGFW_getGlobalHints_OpenGL")) return Error.MissingDeclaration;
        const hints = c.RGFW_getGlobalHints_OpenGL();
        return if (hints == null) null else ptrCast(*GlHints, hints);
    }

    pub fn createContext(win: *Window, hints: ?*GlHints) Error!?*GlContext {
        if (!@hasDecl(c, "RGFW_window_createContext_OpenGL")) return Error.MissingDeclaration;
        const ctx = c.RGFW_window_createContext_OpenGL(cWindow(win), if (hints) |h| ptrCast(*c.RGFW_glHints, h) else null);
        return zigGlContext(ctx);
    }

    pub fn createContextPtr(win: *Window, ctx: *GlContext, hints: ?*GlHints) Error!bool {
        if (!@hasDecl(c, "RGFW_window_createContextPtr_OpenGL")) return Error.MissingDeclaration;
        return boolFromC(c.RGFW_window_createContextPtr_OpenGL(cWindow(win), cGlContext(ctx), if (hints) |h| ptrCast(*c.RGFW_glHints, h) else null));
    }

    pub fn getContext(win: *Window) Error!?*GlContext {
        if (!@hasDecl(c, "RGFW_window_getContext_OpenGL")) return Error.MissingDeclaration;
        return zigGlContext(c.RGFW_window_getContext_OpenGL(cWindow(win)));
    }

    pub fn deleteContext(win: *Window, ctx: *GlContext) Error!void {
        if (!@hasDecl(c, "RGFW_window_deleteContext_OpenGL")) return Error.MissingDeclaration;
        c.RGFW_window_deleteContext_OpenGL(cWindow(win), cGlContext(ctx));
    }

    pub fn deleteContextPtr(win: *Window, ctx: *GlContext) Error!void {
        if (!@hasDecl(c, "RGFW_window_deleteContextPtr_OpenGL")) return Error.MissingDeclaration;
        c.RGFW_window_deleteContextPtr_OpenGL(cWindow(win), cGlContext(ctx));
    }

    pub fn contextGetSourceContext(ctx: *GlContext) Error!?*anyopaque {
        if (!@hasDecl(c, "RGFW_glContext_getSourceContext")) return Error.MissingDeclaration;
        return c.RGFW_glContext_getSourceContext(cGlContext(ctx));
    }

    pub fn makeCurrentWindow(win: *Window) Error!void {
        if (!@hasDecl(c, "RGFW_window_makeCurrentWindow_OpenGL")) return Error.MissingDeclaration;
        c.RGFW_window_makeCurrentWindow_OpenGL(cWindow(win));
    }

    pub fn makeCurrentContext(win: ?*Window) Error!void {
        if (!@hasDecl(c, "RGFW_window_makeCurrentContext_OpenGL")) return Error.MissingDeclaration;
        c.RGFW_window_makeCurrentContext_OpenGL(if (win) |w| cWindow(w) else null);
    }

    pub fn swapBuffers(win: *Window) Error!void {
        if (!@hasDecl(c, "RGFW_window_swapBuffers_OpenGL")) return Error.MissingDeclaration;
        c.RGFW_window_swapBuffers_OpenGL(cWindow(win));
    }

    pub fn swapInterval(win: *Window, interval: i32) Error!void {
        if (!@hasDecl(c, "RGFW_window_swapInterval_OpenGL")) return Error.MissingDeclaration;
        c.RGFW_window_swapInterval_OpenGL(cWindow(win), interval);
    }

    pub fn getCurrentContext() Error!?*anyopaque {
        if (!@hasDecl(c, "RGFW_getCurrentContext_OpenGL")) return Error.MissingDeclaration;
        return c.RGFW_getCurrentContext_OpenGL();
    }

    pub fn getCurrentWindow() Error!?*Window {
        if (!@hasDecl(c, "RGFW_getCurrentWindow_OpenGL")) return Error.MissingDeclaration;
        return zigWindow(c.RGFW_getCurrentWindow_OpenGL());
    }

    pub fn getProcAddress(procname: [:0]const u8) Error!Proc {
        if (!@hasDecl(c, "RGFW_getProcAddress_OpenGL")) return Error.MissingDeclaration;
        return c.RGFW_getProcAddress_OpenGL(procname.ptr);
    }

    pub fn extensionSupported(extension: []const u8) Error!bool {
        if (!@hasDecl(c, "RGFW_extensionSupported_OpenGL")) return Error.MissingDeclaration;
        return boolFromC(c.RGFW_extensionSupported_OpenGL(extension.ptr, extension.len));
    }

    pub fn extensionSupportedPlatform(extension: []const u8) Error!bool {
        if (!@hasDecl(c, "RGFW_extensionSupportedPlatform_OpenGL")) return Error.MissingDeclaration;
        return boolFromC(c.RGFW_extensionSupportedPlatform_OpenGL(extension.ptr, extension.len));
    }
};

pub const egl = struct {
    pub fn createContext(win: *Window, hints: ?*GlHints) Error!?*EglContext {
        if (!@hasDecl(c, "RGFW_window_createContext_EGL")) return Error.MissingDeclaration;
        const ctx = c.RGFW_window_createContext_EGL(cWindow(win), if (hints) |h| ptrCast(*c.RGFW_glHints, h) else null);
        return zigEglContext(ctx);
    }

    pub fn createContextPtr(win: *Window, ctx: *EglContext, hints: ?*GlHints) Error!bool {
        if (!@hasDecl(c, "RGFW_window_createContextPtr_EGL")) return Error.MissingDeclaration;
        return boolFromC(c.RGFW_window_createContextPtr_EGL(cWindow(win), cEglContext(ctx), if (hints) |h| ptrCast(*c.RGFW_glHints, h) else null));
    }

    pub fn deleteContext(win: *Window, ctx: *EglContext) Error!void {
        if (!@hasDecl(c, "RGFW_window_deleteContext_EGL")) return Error.MissingDeclaration;
        c.RGFW_window_deleteContext_EGL(cWindow(win), cEglContext(ctx));
    }

    pub fn deleteContextPtr(win: *Window, ctx: *EglContext) Error!void {
        if (!@hasDecl(c, "RGFW_window_deleteContextPtr_EGL")) return Error.MissingDeclaration;
        c.RGFW_window_deleteContextPtr_EGL(cWindow(win), cEglContext(ctx));
    }

    pub fn getContext(win: *Window) Error!?*EglContext {
        if (!@hasDecl(c, "RGFW_window_getContext_EGL")) return Error.MissingDeclaration;
        return zigEglContext(c.RGFW_window_getContext_EGL(cWindow(win)));
    }

    pub fn getDisplay() Error!?*anyopaque {
        if (!@hasDecl(c, "RGFW_getDisplay_EGL")) return Error.MissingDeclaration;
        return c.RGFW_getDisplay_EGL();
    }

    pub fn contextGetSourceContext(ctx: *EglContext) Error!?*anyopaque {
        if (!@hasDecl(c, "RGFW_eglContext_getSourceContext")) return Error.MissingDeclaration;
        return c.RGFW_eglContext_getSourceContext(cEglContext(ctx));
    }

    pub fn contextGetSurface(ctx: *EglContext) Error!?*anyopaque {
        if (!@hasDecl(c, "RGFW_eglContext_getSurface")) return Error.MissingDeclaration;
        return c.RGFW_eglContext_getSurface(cEglContext(ctx));
    }

    pub fn contextWlEglWindow(ctx: *EglContext) Error!?*WlEglWindow {
        if (!@hasDecl(c, "RGFW_eglContext_wlEGLWindow")) return Error.MissingDeclaration;
        const win = c.RGFW_eglContext_wlEGLWindow(cEglContext(ctx));
        return if (win == null) null else ptrCast(*WlEglWindow, win);
    }

    pub fn swapBuffers(win: *Window) Error!void {
        if (!@hasDecl(c, "RGFW_window_swapBuffers_EGL")) return Error.MissingDeclaration;
        c.RGFW_window_swapBuffers_EGL(cWindow(win));
    }

    pub fn makeCurrentWindow(win: *Window) Error!void {
        if (!@hasDecl(c, "RGFW_window_makeCurrentWindow_EGL")) return Error.MissingDeclaration;
        c.RGFW_window_makeCurrentWindow_EGL(cWindow(win));
    }

    pub fn makeCurrentContext(win: ?*Window) Error!void {
        if (!@hasDecl(c, "RGFW_window_makeCurrentContext_EGL")) return Error.MissingDeclaration;
        c.RGFW_window_makeCurrentContext_EGL(if (win) |w| cWindow(w) else null);
    }

    pub fn getCurrentContext() Error!?*anyopaque {
        if (!@hasDecl(c, "RGFW_getCurrentContext_EGL")) return Error.MissingDeclaration;
        return c.RGFW_getCurrentContext_EGL();
    }

    pub fn getCurrentWindow() Error!?*Window {
        if (!@hasDecl(c, "RGFW_getCurrentWindow_EGL")) return Error.MissingDeclaration;
        return zigWindow(c.RGFW_getCurrentWindow_EGL());
    }

    pub fn swapInterval(win: *Window, interval: i32) Error!void {
        if (!@hasDecl(c, "RGFW_window_swapInterval_EGL")) return Error.MissingDeclaration;
        c.RGFW_window_swapInterval_EGL(cWindow(win), interval);
    }

    pub fn getProcAddress(procname: [:0]const u8) Error!Proc {
        if (!@hasDecl(c, "RGFW_getProcAddress_EGL")) return Error.MissingDeclaration;
        return c.RGFW_getProcAddress_EGL(procname.ptr);
    }

    pub fn extensionSupported(extension: []const u8) Error!bool {
        if (!@hasDecl(c, "RGFW_extensionSupported_EGL")) return Error.MissingDeclaration;
        return boolFromC(c.RGFW_extensionSupported_EGL(extension.ptr, extension.len));
    }

    pub fn extensionSupportedPlatform(extension: []const u8) Error!bool {
        if (!@hasDecl(c, "RGFW_extensionSupportedPlatform_EGL")) return Error.MissingDeclaration;
        return boolFromC(c.RGFW_extensionSupportedPlatform_EGL(extension.ptr, extension.len));
    }
};

pub const vulkan = struct {
    pub fn getInstanceProcAddress(instance: ?*anyopaque, procname: [:0]const u8) Error!Proc {
        if (!@hasDecl(c, "RGFW_getInstanceProcAddress_Vulkan")) return Error.MissingDeclaration;
        return c.RGFW_getInstanceProcAddress_Vulkan(@ptrCast(instance), procname.ptr);
    }

    pub fn getRequiredInstanceExtensions() Error![]const [*:0]const u8 {
        if (!@hasDecl(c, "RGFW_getRequiredInstanceExtensions_Vulkan")) return Error.MissingDeclaration;
        var count: usize = 0;
        const extensions = c.RGFW_getRequiredInstanceExtensions_Vulkan(&count);
        if (extensions == null) return Error.NullPointer;
        return @as([*]const [*:0]const u8, @ptrCast(extensions))[0..count];
    }

    pub fn createSurface(win: *Window, instance: ?*anyopaque, surface_ptr: *anyopaque) Error!i32 {
        if (!@hasDecl(c, "RGFW_window_createSurface_Vulkan")) return Error.MissingDeclaration;
        return @intFromEnum(c.RGFW_window_createSurface_Vulkan(cWindow(win), @ptrCast(instance), @ptrCast(surface_ptr)));
    }

    pub fn getPhysicalDevicePresentationSupport(instance: ?*anyopaque, physical_device: ?*anyopaque, queue_family_index: u32) Error!bool {
        if (!@hasDecl(c, "RGFW_getPhysicalDevicePresentationSupport_Vulkan")) return Error.MissingDeclaration;
        return boolFromC(c.RGFW_getPhysicalDevicePresentationSupport_Vulkan(@ptrCast(instance), @ptrCast(physical_device), @intCast(queue_family_index)));
    }
};

pub const directx = struct {
    pub fn createSwapChain(win: *Window, factory: *DxgiFactory, device: *Unknown, swapchain: **DxgiSwapChain) Error!i32 {
        if (!@hasDecl(c, "RGFW_window_createSwapChain_DirectX")) return Error.MissingDeclaration;
        return @intCast(c.RGFW_window_createSwapChain_DirectX(
            cWindow(win),
            @ptrCast(factory),
            @ptrCast(device),
            @ptrCast(swapchain),
        ));
    }
};

pub const webgpu = struct {
    pub fn createSurface(win: *Window, instance: *anyopaque) Error!?*anyopaque {
        if (!@hasDecl(c, "RGFW_window_createSurface_WebGPU")) return Error.MissingDeclaration;
        return c.RGFW_window_createSurface_WebGPU(cWindow(win), @ptrCast(instance));
    }
};

pub const platform = struct {
    pub fn createWindow(name: [:0]const u8, flags: WindowFlags, win: *Window) Error!?*Window {
        if (!@hasDecl(c, "RGFW_createWindowPlatform")) return Error.MissingDeclaration;
        return zigWindow(c.RGFW_createWindowPlatform(name.ptr, @intCast(flags), cWindow(win)));
    }

    pub fn closeWindow(win: *Window) Error!void {
        if (!@hasDecl(c, "RGFW_window_closePlatform")) return Error.MissingDeclaration;
        c.RGFW_window_closePlatform(cWindow(win));
    }

    pub fn setMouse(win: *Window, mouse_ptr: *Mouse) Error!bool {
        if (!@hasDecl(c, "RGFW_window_setMousePlatform")) return Error.MissingDeclaration;
        return boolFromC(c.RGFW_window_setMousePlatform(cWindow(win), cMouse(mouse_ptr)));
    }

    pub fn setFlagsInternal(win: *Window, flags: WindowFlags, cmp_flags: WindowFlags) Error!void {
        if (!@hasDecl(c, "RGFW_window_setFlagsInternal")) return Error.MissingDeclaration;
        c.RGFW_window_setFlagsInternal(cWindow(win), @intCast(flags), @intCast(cmp_flags));
    }

    pub fn initX11(class_name: ?[:0]const u8, flags: InitFlags) Error!i32 {
        if (!@hasDecl(c, "RGFW_initPlatform_X11")) return Error.MissingDeclaration;
        return @intCast(c.RGFW_initPlatform_X11(optionalCString(class_name), @intCast(flags)));
    }

    pub fn deinitX11() Error!void {
        if (!@hasDecl(c, "RGFW_deinitPlatform_X11")) return Error.MissingDeclaration;
        c.RGFW_deinitPlatform_X11();
    }

    pub fn initWayland(class_name: ?[:0]const u8, flags: InitFlags) Error!i32 {
        if (!@hasDecl(c, "RGFW_initPlatform_Wayland")) return Error.MissingDeclaration;
        return @intCast(c.RGFW_initPlatform_Wayland(optionalCString(class_name), @intCast(flags)));
    }

    pub fn deinitWayland() Error!void {
        if (!@hasDecl(c, "RGFW_deinitPlatform_Wayland")) return Error.MissingDeclaration;
        c.RGFW_deinitPlatform_Wayland();
    }

    pub fn loadX11() Error!void {
        if (!@hasDecl(c, "RGFW_load_X11")) return Error.MissingDeclaration;
        c.RGFW_load_X11();
    }

    pub fn loadWayland() Error!void {
        if (!@hasDecl(c, "RGFW_load_Wayland")) return Error.MissingDeclaration;
        c.RGFW_load_Wayland();
    }

    pub fn unixGetTimeNs() Error!u64 {
        if (!@hasDecl(c, "RGFW_unix_getTimeNS")) return Error.MissingDeclaration;
        return @intCast(c.RGFW_unix_getTimeNS());
    }

    pub fn unixStringLen(name: [:0]const u8) Error!usize {
        if (!@hasDecl(c, "RGFW_unix_stringlen")) return Error.MissingDeclaration;
        return c.RGFW_unix_stringlen(name.ptr);
    }

    pub fn waitForShowEventX11(win: *Window) Error!bool {
        if (!@hasDecl(c, "RGFW_waitForShowEvent_X11")) return Error.MissingDeclaration;
        return boolFromC(c.RGFW_waitForShowEvent_X11(cWindow(win)));
    }

    pub fn win32GetDarkModeState() Error!bool {
        if (!@hasDecl(c, "RGFW_win32_getDarkModeState")) return Error.MissingDeclaration;
        return boolFromC(c.RGFW_win32_getDarkModeState());
    }

    pub fn win32MakeWindowDarkMode(win: *Window, state: bool) Error!void {
        if (!@hasDecl(c, "RGFW_win32_makeWindowDarkMode")) return Error.MissingDeclaration;
        c.RGFW_win32_makeWindowDarkMode(cWindow(win), boolToC(state));
    }

    pub fn win32GetMode(dev_mode: *anyopaque, mode: *MonitorMode) Error!void {
        if (!@hasDecl(c, "RGFW_win32_getMode")) return Error.MissingDeclaration;
        c.RGFW_win32_getMode(@ptrCast(dev_mode), cMonitorMode(mode));
    }

    pub fn win32CreateMonitor(adapter: *anyopaque, display_device: *anyopaque) Error!void {
        if (!@hasDecl(c, "RGFW_win32_createMonitor")) return Error.MissingDeclaration;
        c.RGFW_win32_createMonitor(@ptrCast(adapter), @ptrCast(display_device));
    }

    pub fn cocoaYTransform(y: f32) Error!f32 {
        if (!@hasDecl(c, "RGFW_cocoaYTransform")) return Error.MissingDeclaration;
        return c.RGFW_cocoaYTransform(y);
    }
};

pub const internals = struct {
    pub fn attribStackInit(stack: *anyopaque, attribs: []i32) Error!void {
        if (!@hasDecl(c, "RGFW_attribStack_init")) return Error.MissingDeclaration;
        c.RGFW_attribStack_init(@ptrCast(stack), attribs.ptr, attribs.len);
    }

    pub fn attribStackPushAttrib(stack: *anyopaque, attrib: i32) Error!void {
        if (!@hasDecl(c, "RGFW_attribStack_pushAttrib")) return Error.MissingDeclaration;
        c.RGFW_attribStack_pushAttrib(@ptrCast(stack), attrib);
    }

    pub fn attribStackPushAttribs(stack: *anyopaque, attrib1: i32, attrib2: i32) Error!void {
        if (!@hasDecl(c, "RGFW_attribStack_pushAttribs")) return Error.MissingDeclaration;
        c.RGFW_attribStack_pushAttribs(@ptrCast(stack), attrib1, attrib2);
    }

    pub fn initKeycodes() Error!void {
        if (!@hasDecl(c, "RGFW_initKeycodes")) return Error.MissingDeclaration;
        c.RGFW_initKeycodes();
    }

    pub fn initKeycodesPlatform() Error!void {
        if (!@hasDecl(c, "RGFW_initKeycodesPlatform")) return Error.MissingDeclaration;
        c.RGFW_initKeycodesPlatform();
    }

    pub fn resetPrevState() Error!void {
        if (!@hasDecl(c, "RGFW_resetPrevState")) return Error.MissingDeclaration;
        c.RGFW_resetPrevState();
    }

    pub fn resetKey() Error!void {
        if (!@hasDecl(c, "RGFW_resetKey")) return Error.MissingDeclaration;
        c.RGFW_resetKey();
    }

    pub fn keyUpdateKeyMod(win: *Window, mod: KeyMod, value: bool) Error!void {
        if (!@hasDecl(c, "RGFW_keyUpdateKeyMod")) return Error.MissingDeclaration;
        c.RGFW_keyUpdateKeyMod(cWindow(win), @intCast(mod), boolToC(value));
    }

    pub fn keyUpdateKeyMods(win: *Window, capital: bool, numlock: bool, scroll: bool) Error!void {
        if (!@hasDecl(c, "RGFW_keyUpdateKeyMods")) return Error.MissingDeclaration;
        c.RGFW_keyUpdateKeyMods(cWindow(win), boolToC(capital), boolToC(numlock), boolToC(scroll));
    }

    pub fn keyUpdateKeyModsEx(win: *Window, capital: bool, numlock: bool, control: bool, alt: bool, shift: bool, super: bool, scroll: bool) Error!void {
        if (!@hasDecl(c, "RGFW_keyUpdateKeyModsEx")) return Error.MissingDeclaration;
        c.RGFW_keyUpdateKeyModsEx(cWindow(win), boolToC(capital), boolToC(numlock), boolToC(control), boolToC(alt), boolToC(shift), boolToC(super), boolToC(scroll));
    }

    pub fn loadGl() Error!bool {
        if (!@hasDecl(c, "RGFW_loadGL")) return Error.MissingDeclaration;
        return boolFromC(c.RGFW_loadGL());
    }

    pub fn unloadGl() Error!void {
        if (!@hasDecl(c, "RGFW_unloadGL")) return Error.MissingDeclaration;
        c.RGFW_unloadGL();
    }

    pub fn loadEgl() Error!bool {
        if (!@hasDecl(c, "RGFW_loadEGL")) return Error.MissingDeclaration;
        return boolFromC(c.RGFW_loadEGL());
    }

    pub fn unloadEgl() Error!void {
        if (!@hasDecl(c, "RGFW_unloadEGL")) return Error.MissingDeclaration;
        c.RGFW_unloadEGL();
    }

    pub fn loadVulkan() Error!bool {
        if (!@hasDecl(c, "RGFW_loadVulkan")) return Error.MissingDeclaration;
        return boolFromC(c.RGFW_loadVulkan());
    }

    pub fn unloadVulkan() Error!void {
        if (!@hasDecl(c, "RGFW_unloadVulkan")) return Error.MissingDeclaration;
        c.RGFW_unloadVulkan();
    }

    pub fn monitorsRefresh() Error!void {
        if (!@hasDecl(c, "RGFW_monitors_refresh")) return Error.MissingDeclaration;
        c.RGFW_monitors_refresh();
    }

    pub fn monitorsAdd(mon: *const Monitor) Error!?*MonitorNode {
        if (!@hasDecl(c, "RGFW_monitors_add")) return Error.MissingDeclaration;
        return zigMonitorNode(c.RGFW_monitors_add(ptrCast(*const c.RGFW_monitor, mon)));
    }

    pub fn monitorsRemove(node: *MonitorNode, prev: *MonitorNode) Error!void {
        if (!@hasDecl(c, "RGFW_monitors_remove")) return Error.MissingDeclaration;
        c.RGFW_monitors_remove(cMonitorNode(node), cMonitorNode(prev));
    }

    pub fn monitorNodeFree(node: *MonitorNode) Error!void {
        if (!@hasDecl(c, "RGFW_monitorNode_free")) return Error.MissingDeclaration;
        c.RGFW_monitorNode_free(cMonitorNode(node));
    }

    pub fn setBit(value: *u32, mask: u32, set: bool) Error!void {
        if (!@hasDecl(c, "RGFW_setBit")) return Error.MissingDeclaration;
        c.RGFW_setBit(value, mask, boolToC(set));
    }

    pub fn splitBpp(bpp: u32, mode: *MonitorMode) Error!void {
        if (!@hasDecl(c, "RGFW_splitBPP")) return Error.MissingDeclaration;
        c.RGFW_splitBPP(bpp, cMonitorMode(mode));
    }

    pub fn windowShowMouseFlags(win: *Window, visible: bool) Error!void {
        if (!@hasDecl(c, "RGFW_window_showMouseFlags")) return Error.MissingDeclaration;
        c.RGFW_window_showMouseFlags(cWindow(win), boolToC(visible));
    }

    pub fn windowCaptureMousePlatform(win: *Window, state: bool) Error!void {
        if (!@hasDecl(c, "RGFW_window_captureMousePlatform")) return Error.MissingDeclaration;
        c.RGFW_window_captureMousePlatform(cWindow(win), boolToC(state));
    }

    pub fn windowSetRawMouseModePlatform(win: *Window, state: bool) Error!void {
        if (!@hasDecl(c, "RGFW_window_setRawMouseModePlatform")) return Error.MissingDeclaration;
        c.RGFW_window_setRawMouseModePlatform(cWindow(win), boolToC(state));
    }
};

pub const callbacks = struct {
    pub fn windowMaximized(win: *Window, rect: Rect) Error!void {
        if (!@hasDecl(c, "RGFW_windowMaximizedCallback")) return Error.MissingDeclaration;
        c.RGFW_windowMaximizedCallback(cWindow(win), rect.x, rect.y, rect.w, rect.h);
    }

    pub fn windowMinimized(win: *Window) Error!void {
        if (!@hasDecl(c, "RGFW_windowMinimizedCallback")) return Error.MissingDeclaration;
        c.RGFW_windowMinimizedCallback(cWindow(win));
    }

    pub fn windowRestored(win: *Window, rect: Rect) Error!void {
        if (!@hasDecl(c, "RGFW_windowRestoredCallback")) return Error.MissingDeclaration;
        c.RGFW_windowRestoredCallback(cWindow(win), rect.x, rect.y, rect.w, rect.h);
    }

    pub fn windowMoved(win: *Window, pos: Position) Error!void {
        if (!@hasDecl(c, "RGFW_windowMovedCallback")) return Error.MissingDeclaration;
        c.RGFW_windowMovedCallback(cWindow(win), pos.x, pos.y);
    }

    pub fn windowResized(win: *Window, size: Size) Error!void {
        if (!@hasDecl(c, "RGFW_windowResizedCallback")) return Error.MissingDeclaration;
        c.RGFW_windowResizedCallback(cWindow(win), size.w, size.h);
    }

    pub fn windowClose(win: *Window) Error!void {
        if (!@hasDecl(c, "RGFW_windowCloseCallback")) return Error.MissingDeclaration;
        c.RGFW_windowCloseCallback(cWindow(win));
    }

    pub fn mouseMotion(win: *Window, pos: Position) Error!void {
        if (!@hasDecl(c, "RGFW_mouseMotionCallback")) return Error.MissingDeclaration;
        c.RGFW_mouseMotionCallback(cWindow(win), pos.x, pos.y);
    }

    pub fn rawMotion(win: *Window, vector: MouseVector) Error!void {
        if (!@hasDecl(c, "RGFW_rawMotionCallback")) return Error.MissingDeclaration;
        c.RGFW_rawMotionCallback(cWindow(win), vector.x, vector.y);
    }

    pub fn windowRefresh(win: *Window, rect: Rect) Error!void {
        if (!@hasDecl(c, "RGFW_windowRefreshCallback")) return Error.MissingDeclaration;
        c.RGFW_windowRefreshCallback(cWindow(win), rect.x, rect.y, rect.w, rect.h);
    }

    pub fn windowFocus(win: *Window, in_focus: bool) Error!void {
        if (!@hasDecl(c, "RGFW_windowFocusCallback")) return Error.MissingDeclaration;
        c.RGFW_windowFocusCallback(cWindow(win), boolToC(in_focus));
    }

    pub fn mouseNotify(win: *Window, pos: Position, status: bool) Error!void {
        if (!@hasDecl(c, "RGFW_mouseNotifyCallback")) return Error.MissingDeclaration;
        c.RGFW_mouseNotifyCallback(cWindow(win), pos.x, pos.y, boolToC(status));
    }

    pub fn dataDrop(win: *Window, data: [:0]const u8, data_type: DataTransferType) Error!void {
        if (!@hasDecl(c, "RGFW_dataDropCallback")) return Error.MissingDeclaration;
        c.RGFW_dataDropCallback(cWindow(win), data.ptr, data.len, @intCast(data_type));
    }

    pub fn dataDrag(win: *Window, data_type: DataTransferType, action: DndActionType, pos: Position) Error!void {
        if (!@hasDecl(c, "RGFW_dataDragCallback")) return Error.MissingDeclaration;
        c.RGFW_dataDragCallback(cWindow(win), @intCast(data_type), @intCast(action), pos.x, pos.y);
    }

    pub fn keyChar(win: *Window, codepoint: u32) Error!void {
        if (!@hasDecl(c, "RGFW_keyCharCallback")) return Error.MissingDeclaration;
        c.RGFW_keyCharCallback(cWindow(win), codepoint);
    }

    pub fn keyEvent(win: *Window, key_code: Key, mod: KeyMod, repeat: bool, press: bool) Error!void {
        if (!@hasDecl(c, "RGFW_keyCallback")) return Error.MissingDeclaration;
        c.RGFW_keyCallback(cWindow(win), @intCast(key_code), @intCast(mod), boolToC(repeat), boolToC(press));
    }

    pub fn mouseButton(win: *Window, button: MouseButton, press: bool) Error!void {
        if (!@hasDecl(c, "RGFW_mouseButtonCallback")) return Error.MissingDeclaration;
        c.RGFW_mouseButtonCallback(cWindow(win), @intCast(button), boolToC(press));
    }

    pub fn mouseScroll(win: *Window, vector: MouseVector) Error!void {
        if (!@hasDecl(c, "RGFW_mouseScrollCallback")) return Error.MissingDeclaration;
        c.RGFW_mouseScrollCallback(cWindow(win), vector.x, vector.y);
    }

    pub fn scaleUpdated(win: *Window, scale: Scale) Error!void {
        if (!@hasDecl(c, "RGFW_scaleUpdatedCallback")) return Error.MissingDeclaration;
        c.RGFW_scaleUpdatedCallback(cWindow(win), scale.x, scale.y);
    }

    pub fn monitor(win: *Window, mon: *const Monitor, connected: bool) Error!void {
        if (!@hasDecl(c, "RGFW_monitorCallback")) return Error.MissingDeclaration;
        c.RGFW_monitorCallback(cWindow(win), ptrCast(*const c.RGFW_monitor, mon), boolToC(connected));
    }
};

pub const native = struct {
    pub fn osxInitView(win: *Window) Error!void {
        if (!@hasDecl(c, "RGFW_osx_initView")) return Error.MissingDeclaration;
        c.RGFW_osx_initView(cWindow(win));
    }

    pub fn getNSScreenForDisplayUInt(display_id: u32) Error!?*anyopaque {
        if (!@hasDecl(c, "RGFW_getNSScreenForDisplayUInt")) return Error.MissingDeclaration;
        return c.RGFW_getNSScreenForDisplayUInt(display_id);
    }

    pub fn unixParseUri(win: *Window, data: [:0]u8) Error!void {
        if (!@hasDecl(c, "RGFW_unix_parseURI")) return Error.MissingDeclaration;
        c.RGFW_unix_parseURI(cWindow(win), data.ptr);
    }

    pub fn winapiWindowGetStyle(win: *Window, flags: WindowFlags) Error!u32 {
        if (!@hasDecl(c, "RGFW_winapi_window_getStyle")) return Error.MissingDeclaration;
        return @intCast(c.RGFW_winapi_window_getStyle(cWindow(win), @intCast(flags)));
    }

    pub fn winapiWindowGetExStyle(win: *Window, flags: WindowFlags) Error!u32 {
        if (!@hasDecl(c, "RGFW_winapi_window_getExStyle")) return Error.MissingDeclaration;
        return @intCast(c.RGFW_winapi_window_getExStyle(cWindow(win), @intCast(flags)));
    }

    pub fn xGetSystemContentDpi() Error!f32 {
        if (!@hasDecl(c, "RGFW_XGetSystemContentDPI")) return Error.MissingDeclaration;
        var dpi: f32 = 0;
        c.RGFW_XGetSystemContentDPI(&dpi);
        return dpi;
    }

    pub fn xHandleClipboardSelection(event: *anyopaque) Error!void {
        if (!@hasDecl(c, "RGFW_XHandleClipboardSelection")) return Error.MissingDeclaration;
        c.RGFW_XHandleClipboardSelection(@ptrCast(event));
    }

    pub fn xHandleEvent() Error!void {
        if (!@hasDecl(c, "RGFW_XHandleEvent")) return Error.MissingDeclaration;
        c.RGFW_XHandleEvent();
    }

    pub fn xImageGetFormat(image: *anyopaque) Error!Format {
        if (!@hasDecl(c, "RGFW_XImage_getFormat")) return Error.MissingDeclaration;
        return @intCast(c.RGFW_XImage_getFormat(@ptrCast(image)));
    }

    pub fn xErrorHandler(display: *anyopaque, event: *anyopaque) Error!i32 {
        if (!@hasDecl(c, "RGFW_XErrorHandler")) return Error.MissingDeclaration;
        return @intCast(c.RGFW_XErrorHandler(@ptrCast(display), @ptrCast(event)));
    }

    pub fn x11IcCallback(ic: *anyopaque, client_data: [*:0]u8, call_data: [*:0]u8) Error!void {
        if (!@hasDecl(c, "RGFW_x11_icCallback")) return Error.MissingDeclaration;
        c.RGFW_x11_icCallback(@ptrCast(ic), client_data, call_data);
    }

    pub fn x11ImCallback(im: *anyopaque, client_data: [*:0]u8, call_data: [*:0]u8) Error!void {
        if (!@hasDecl(c, "RGFW_x11_imCallback")) return Error.MissingDeclaration;
        c.RGFW_x11_imCallback(@ptrCast(im), client_data, call_data);
    }

    pub fn x11ImInitCallback(display: *anyopaque, client_data: *anyopaque, call_data: *anyopaque) Error!void {
        if (!@hasDecl(c, "RGFW_x11_imInitCallback")) return Error.MissingDeclaration;
        c.RGFW_x11_imInitCallback(@ptrCast(display), @ptrCast(client_data), @ptrCast(call_data));
    }

    pub fn xGetMode(crtc_info: *anyopaque, resources: *anyopaque, mode_id: u64, found_mode: *MonitorMode) Error!?*anyopaque {
        if (!@hasDecl(c, "RGFW_XGetMode")) return Error.MissingDeclaration;
        return c.RGFW_XGetMode(@ptrCast(crtc_info), @ptrCast(resources), @intCast(mode_id), cMonitorMode(found_mode));
    }

    pub fn windowGetVisual(visual: *anyopaque, transparent: bool) Error!void {
        if (!@hasDecl(c, "RGFW_window_getVisual")) return Error.MissingDeclaration;
        c.RGFW_window_getVisual(@ptrCast(visual), boolToC(transparent));
    }
};

test "wrapper type smoke" {
    if (false) {
        var event: Event = undefined;
        var callback_set: Callbacks = undefined;
        var image_bytes: [4]u8 = undefined;
        var mode: MonitorMode = undefined;
        var gamma_values: [3]u16 = undefined;
        var monitors: [4]?*Monitor = undefined;

        const win: *Window = undefined;
        const mon: *Monitor = undefined;
        const surface_ptr: *Surface = undefined;
        const mouse_ptr: *Mouse = undefined;
        const gl_ctx: *GlContext = undefined;
        const egl_ctx: *EglContext = undefined;
        const hints: *GlHints = undefined;
        const transfer: *DataTransfer = undefined;
        const any: *anyopaque = undefined;
        const image = Image{ .data = image_bytes[0..], .w = 1, .h = 1, .format = 0 };

        _ = init(null, 0);
        deinit();
        _ = copyImageData64(image_bytes[0..], .{ .w = 1, .h = 1 }, 0, image_bytes[0..], 0, false, null);
        const layout = ColorLayout{ .r = 0, .g = 1, .b = 2, .a = 3, .channels = 4 };
        _ = convertImageData64(image_bytes[0..], image_bytes[0..], &layout, &layout, 1, false);
        var utf8_index: usize = 0;
        _ = isLatin("abc");
        _ = decodeUtf8("abc", &utf8_index);
        _ = extensionSupportedStr("GL_EXT_test", "GL_EXT_test");
        _ = checkEvent(&event);
        setAllEventCallbacks(null, &callback_set);
        _ = createWindow("x", .{ .x = 0, .y = 0 }, .{ .w = 1, .h = 1 }, 0);
        _ = createWindowPtr("x", .{ .x = 0, .y = 0 }, .{ .w = 1, .h = 1 }, 0, win);
        setRootWindow(win);
        _ = getRootWindow();

        _ = window.createSurface(win, image);
        _ = window.createSurfacePtr(win, image, surface_ptr);
        window.setEnabledEvents(win, 0);
        _ = window.getEnabledEvents(win);
        window.setEventState(win, 0, true);
        _ = window.getSrc(win);
        _ = window.getWindowWayland(win);
        _ = window.checkEvent(win, &event);
        _ = window.getDataDrop(win);
        window.showMouse(win, true);

        _ = monitor.getAll(monitors[0..]);
        _ = monitor.getMonitors();
        _ = monitor.getModes(mon);
        _ = monitor.getModesPtr(mon);
        _ = monitor.findClosestMode(mon, &mode);
        _ = monitor.getGammaRamp(mon);
        var ramp: GammaRamp = undefined;
        _ = monitor.getGammaRampPtr(mon, &ramp);
        _ = monitor.modeCompare(&mode, &mode, 0);
        _ = monitor.setGammaPtr(mon, 1.0, gamma_values[0..]);

        _ = surface.createPtr(image, surface_ptr);
        _ = surface.getNativeImage(surface_ptr);
        surface.setConvertFunc(surface_ptr, null);
        _ = mouse.set(win, mouse_ptr);

        _ = clipboard.readPtr(image_bytes[0..], transfer);
        eventQueue.push(&event);
        _ = eventQueue.popWindow(win);
        _ = debug.setCallback(null);

        _ = opengl.createContext(win, hints);
        _ = opengl.createContextPtr(win, gl_ctx, hints);
        _ = opengl.contextGetSourceContext(gl_ctx);
        _ = egl.createContext(win, hints);
        _ = egl.createContextPtr(win, egl_ctx, hints);
        _ = egl.contextWlEglWindow(egl_ctx);
        _ = vulkan.getInstanceProcAddress(any, "vk");
        _ = vulkan.createSurface(win, any, any);
        _ = vulkan.getPhysicalDevicePresentationSupport(any, any, 0);
        var swapchain: *DxgiSwapChain = undefined;
        const factory: *DxgiFactory = undefined;
        const device: *Unknown = undefined;
        _ = directx.createSwapChain(win, factory, device, &swapchain);
        _ = webgpu.createSurface(win, any);

        _ = platform.createWindow("x", 0, win);
        _ = platform.closeWindow(win);
        _ = platform.setMouse(win, mouse_ptr);
        _ = platform.setFlagsInternal(win, 0, 0);
        _ = platform.initX11(null, 0);
        _ = platform.deinitX11();
        _ = platform.initWayland(null, 0);
        _ = platform.deinitWayland();
        _ = platform.loadX11();
        _ = platform.loadWayland();
        _ = platform.unixGetTimeNs();
        _ = platform.unixStringLen("x");
        _ = platform.waitForShowEventX11(win);
        _ = platform.win32GetDarkModeState();
        _ = platform.win32MakeWindowDarkMode(win, true);
        _ = platform.cocoaYTransform(1.0);

        _ = internals.initKeycodes();
        _ = internals.initKeycodesPlatform();
        _ = internals.resetPrevState();
        _ = internals.resetKey();
        _ = internals.keyUpdateKeyMod(win, 0, true);
        _ = internals.keyUpdateKeyMods(win, false, false, false);
        _ = internals.keyUpdateKeyModsEx(win, false, false, false, false, false, false, false);
        _ = internals.loadGl();
        _ = internals.unloadGl();
        _ = internals.loadEgl();
        _ = internals.unloadEgl();
        _ = internals.loadVulkan();
        _ = internals.unloadVulkan();
        _ = internals.monitorsRefresh();
        const node: *MonitorNode = undefined;
        _ = internals.monitorsAdd(mon);
        _ = internals.monitorsRemove(node, node);
        _ = internals.monitorNodeFree(node);
        var bits: u32 = 0;
        _ = internals.setBit(&bits, 1, true);
        _ = internals.splitBpp(32, &mode);
        _ = internals.windowShowMouseFlags(win, true);
        _ = internals.attribStackInit(any, @as([]i32, &.{}));
        _ = internals.attribStackPushAttrib(any, 0);
        _ = internals.attribStackPushAttribs(any, 0, 0);
        _ = internals.windowCaptureMousePlatform(win, true);
        _ = internals.windowSetRawMouseModePlatform(win, true);

        _ = callbacks.windowMaximized(win, .{ .x = 0, .y = 0, .w = 1, .h = 1 });
        _ = callbacks.windowMinimized(win);
        _ = callbacks.windowRestored(win, .{ .x = 0, .y = 0, .w = 1, .h = 1 });
        _ = callbacks.windowMoved(win, .{ .x = 0, .y = 0 });
        _ = callbacks.windowResized(win, .{ .w = 1, .h = 1 });
        _ = callbacks.windowClose(win);
        _ = callbacks.mouseMotion(win, .{ .x = 0, .y = 0 });
        _ = callbacks.rawMotion(win, .{ .x = 0, .y = 0 });
        _ = callbacks.windowRefresh(win, .{ .x = 0, .y = 0, .w = 1, .h = 1 });
        _ = callbacks.windowFocus(win, true);
        _ = callbacks.mouseNotify(win, .{ .x = 0, .y = 0 }, true);
        _ = callbacks.dataDrop(win, "data", 0);
        _ = callbacks.dataDrag(win, 0, 0, .{ .x = 0, .y = 0 });
        _ = callbacks.keyChar(win, 'a');
        _ = callbacks.keyEvent(win, 0, 0, false, true);
        _ = callbacks.mouseButton(win, 0, true);
        _ = callbacks.mouseScroll(win, .{ .x = 0, .y = 0 });
        _ = callbacks.scaleUpdated(win, .{ .x = 1, .y = 1 });
        _ = callbacks.monitor(win, mon, true);

        var uri: [4:0]u8 = .{ 'a', 'b', 'c', 0 };
        _ = native.osxInitView(win);
        _ = native.getNSScreenForDisplayUInt(0);
        _ = native.unixParseUri(win, uri[0..3 :0]);
        _ = native.winapiWindowGetStyle(win, 0);
        _ = native.winapiWindowGetExStyle(win, 0);
        _ = native.xGetSystemContentDpi();
        _ = native.xHandleClipboardSelection(any);
        _ = native.xHandleEvent();
        _ = native.xImageGetFormat(any);
        _ = native.xErrorHandler(any, any);
        _ = native.windowGetVisual(any, false);
    }
}
