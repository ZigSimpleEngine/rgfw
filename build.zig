const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const options = .{
        .rgfw_opengl = b.option(bool, "rgfw_opengl", "Force compilation with OpenGL context creation and support") orelse false,
        .rgfw_egl = b.option(bool, "rgfw_egl", "Compiles with EGL context creation support, allowing you to use EGL instead of native OpenGL context functions (WGL/GLX/NSGL)") orelse false,
        .rgfw_vulkan = b.option(bool, "rgfw_vulkan", "Enables Vulkan context creation helper functions, macros, and structure definitions") orelse false,
        .rgfw_directx = b.option(bool, "rgfw_directx", "Exposes and includes DirectX integration helper functions (Windows only)") orelse false,
        .rgfw_webgpu = b.option(bool, "rgfw_webgpu", "Enables WebGPU integration and helper context creation functions") orelse false,
        .rgfw_native = b.option(bool, "rgfw_native", "Exposes and defines native RGFW structures and types that utilize platform_native API structures") orelse false,
        .rgfw_no_info = b.option(bool, "rgfw_no_info", "Prevents defining the global RGFW_info structure") orelse false,
        .rgfw_no_glxwindow = b.option(bool, "rgfw_no_glxwindow", "Disables the usage of GLXWindow for X11 OpenGL contexts") orelse false,
        .rgfw_no_allocate_monitors = b.option(bool, "rgfw_no_allocate_monitors", "Disables dynamic heap allocation of monitor info structures when the preallocated monitor storage limit is exceeded") orelse false,
        .rgfw_no_include_vulkan = b.option(bool, "rgfw_no_include_vulkan", "Disables the automatic inclusion of the vulkan/vulkan.h header, forcing the user to include it manually") orelse false,
        .rgfw_no_static_context = b.option(bool, "rgfw_no_static_context", "Disables initializing with a static global variable context, using heap allocations instead if RGFW is not manually initialized") orelse false,
        .rgfw_no_x11 = b.option(bool, "rgfw_no_x11", "Prevents fallback to X11 if Wayland is requested but is unavailable or fails") orelse false,
        .rgfw_no_x11_cursor = b.option(bool, "rgfw_no_x11_cursor", "Disables Xcursor support completely under X11, falling back to standard cursors") orelse false,
        .rgfw_no_x11_cursor_preload = b.option(bool, "rgfw_no_x11_cursor_preload", "Uses Xcursor under X11, but compiles without dynamically preloading libXcursor, requiring you to link with _lXcursor") orelse false,
        .rgfw_no_x11_ext_preload = b.option(bool, "rgfw_no_x11_ext_preload", "Uses Xext under X11, but compiles without dynamically preloading libXext, requiring you to link with _lXext") orelse false,
        .rgfw_no_x11_xi_preload = b.option(bool, "rgfw_no_x11_xi_preload", "Uses XInput2 under X11, but compiles without dynamically preloading libXi, requiring you to link with _lXi") orelse false,
        .rgfw_no_load_winmm = b.option(bool, "rgfw_no_load_winmm", "Uses winmm on Windows, but compiles without dynamically loading winmm.dll, requiring you to link with _lwinmm") orelse false,
        .rgfw_no_winmm = b.option(bool, "rgfw_no_winmm", "Disables winmm (and timeBeginPeriod) usage entirely under Windows") orelse false,
        .rgfw_no_iokit = b.option(bool, "rgfw_no_iokit", "Disables IOKit framework usage and linking on macOS") orelse false,
        .rgfw_no_unix_clock = b.option(bool, "rgfw_no_unix_clock", "Disables linking POSIX clock functions (clock_gettime) on Unix_like systems") orelse false,
        .rgfw_no_dwm = b.option(bool, "rgfw_no_dwm", "Disables usage and linking of Desktop Window Manager (dwmapi) library on Windows") orelse false,
        .rgfw_no_math = b.option(bool, "rgfw_no_math", "Disables powf and other math library functions, preventing inclusion of <math.h> for minimal systems") orelse false,
        .rgfw_no_passthrough = b.option(bool, "rgfw_no_passthrough", "Disables mouse passthrough functionality and excludes related APIs from compilation") orelse false,
        .rgfw_no_dpi = b.option(bool, "rgfw_no_dpi", "Disables High_DPI calculations and Shcore.dll library loading/usage on Windows") orelse false,
        .rgfw_x11 = b.option(bool, "rgfw_x11", "Forces the X11 backend to be used (default on Unix systems except macOS)") orelse false,
        .rgfw_wayland = b.option(bool, "rgfw_wayland", "Enables compiling with the Wayland backend (Unix only, can be used concurrently with X11 for dynamic dual backend support)") orelse false,
        .rgfw_use_xdl = b.option(bool, "rgfw_use_xdl", "Enables XDL (Xlib Dynamic Loader) to dynamically load X11 functions at runtime (requires including XDL.h)") orelse false,
        .rgfw_advanced_smooth_resize = b.option(bool, "rgfw_advanced_smooth_resize", "Enables advanced methods for smooth resizing on Windows (such as WM_TIMER) and X11 (such as XSync), which might slightly impact performance or memory") orelse false,
        .rgfw_use_int = b.option(bool, "rgfw_use_int", "Forces the use of standard C primitive integer types instead of <stdint.h> types") orelse false,
        .rgfw_custom_backend = b.option(bool, "rgfw_custom_backend", "Disables standard OS backend detection entirely, enabling building/linking with a custom windowing backend") orelse false,
        .rgfw_libdecor = b.option(bool, "rgfw_libdecor", "Enables libdecor support for client_side decorations on Wayland") orelse false,
        .rgfw_cocoa_graphics_switching = b.option(bool, "rgfw_cocoa_graphics_switching", "Enables automatic graphics switching on macOS Cocoa, allowing the system to switch dynamically between integrated and discrete GPUs") orelse false,
        .rgfw_win95 = b.option(bool, "rgfw_win95", "Disables modern Win32 calls and APIs to target Windows 95 compatibility") orelse false,
        .rgfw_c89 = b.option(bool, "rgfw_c89", "Forces compilation with C89 compatibility settings (disables stdint.h/newer features)") orelse false,
        .rgfw_dynamic = b.option(bool, "rgfw_dynamic", "Auto_defined when using both X11 and Wayland concurrently, enabling runtime dynamic platform entry loading, but can be manually defined to configure dynamic execution behavior") orelse false,
        .rgfw_macos = b.option(bool, "rgfw_macos", "Forces or indicates macOS Cocoa target platform compilation") orelse false,
        .rgfw_macos_x11 = b.option(bool, "rgfw_macos_x11", "Forces or indicates macOS X11 target platform compilation") orelse false,
        .rgfw_unix = b.option(bool, "rgfw_unix", "Forces or indicates Unix/Linux target platform compilation") orelse false,
        .rgfw_wasm = b.option(bool, "rgfw_wasm", "Forces or indicates WebAssembly/Emscripten target platform compilation") orelse false,
        .rgfw_windows = b.option(bool, "rgfw_windows", "Forces or indicates Windows target platform compilation") orelse false,
        .rgfw_x11_crash_on_error = b.option(bool, "rgfw_x11_crash_on_error", "Forces an assertion crash immediately when an X11 protocol error is encountered") orelse false,
        .rgfw_cocoa_frame_name = b.option([]const u8, "rgfw_cocoa_frame_name", "Sets a custom Cocoa frame name on macOS"),
        .rgfw_alloc = b.option([]const u8, "rgfw_alloc", "Overrides the default heap allocation function (defaults to standard malloc)"),
        .rgfw_free = b.option([]const u8, "rgfw_free", "Overrides the default deallocation function (defaults to standard free)"),
        .rgfw_userptr = b.option([]const u8, "rgfw_userptr", "Sets a default user pointer argument to be sent to standard allocator calls (defaults to NULL)"),
        .rgfw_export = b.option([]const u8, "rgfw_export", "Configures function declarations to be exported when building RGFW as a separate library/DLL"),
        .rgfw_import = b.option([]const u8, "rgfw_import", "Configures function declarations to be imported when linking against RGFW as an external library"),
        .rgfw_bool_type = b.option([]const u8, "rgfw_bool", "Overrides the underlying boolean type used by RGFW (defaults to u32)"),
        .rgfw_assert = b.option([]const u8, "rgfw_assert", "Overrides the standard assert macro with a custom assertion macro (defaults to assert)"),
        .rgfw_static_assert = b.option([]const u8, "rgfw_static_assert", "Overrides the macro used for compile_time static assertions"),
        .rgfw_snprintf = b.option([]const u8, "rgfw_snprintf", "Overrides the default snprintf function implementation"),
        .rgfw_printf = b.option([]const u8, "rgfw_printf", "Overrides the default printf function implementation (used for debug printing)"),
        .rgfw_memzero = b.option([]const u8, "rgfw_memzero", "Overrides the memory zeroing function (defaults to memset with a size of 0)"),
        .rgfw_memcpy = b.option([]const u8, "rgfw_memcpy", "Overrides the memory copy function (defaults to memcpy)"),
        .rgfw_strncmp = b.option([]const u8, "rgfw_strncmp", "Overrides the string comparison function (defaults to strncmp)"),
        .rgfw_strncpy = b.option([]const u8, "rgfw_strncpy", "Overrides the string copy function (defaults to strncpy)"),
        .rgfw_strstr = b.option([]const u8, "rgfw_strstr", "Overrides the substring search function (defaults to strstr)"),
        .rgfw_strtol = b.option([]const u8, "rgfw_strtol", "Overrides the string_to_long integer parsing function (defaults to strtol)"),
        .rgfw_atof = b.option([]const u8, "rgfw_atof", "Overrides the string_to_float parsing function (defaults to atof)"),
        .rgfw_round = b.option([]const u8, "rgfw_round", "Overrides the custom coordinate rounding macro"),
        .rgfw_roundf = b.option([]const u8, "rgfw_roundf", "Overrides the custom float coordinate rounding macro"),
        .rgfw_min = b.option([]const u8, "rgfw_min", "Overrides the default minimum macro"),
        .rgfw_unused = b.option([]const u8, "rgfw_unused", "Overrides the macro used to suppress unused variable compiler warnings"),
        .rgfw_preallocated_monitors = b.option(u32, "rgfw_preallocated_monitors", "Overrides the preallocated monitor buffer size to avoid dynamic heap allocation (defaults to 6)"),
        .rgfw_max_events = b.option(u32, "rgfw_max_events", "Configures the maximum number of events stored in the internal RGFW event queue (defaults to 32)"),
        .rgfw_xdnd_version = b.option(u32, "rgfw_xdnd_version", "Overrides the default XDnD (Drag and Drop) protocol version (defaults to 5 on X11)"),
        .rgfw_debug = b.option(bool, "rgfw_debug", "Enables RGFW debug mode, printing debug messages and detailed errors when they occur") orelse false,
        .rgfw_implementation = b.option(bool, "rgfw_implementation", "Makes it so the RGFW source code is included in the compilation unit") orelse false,
    };

    const rgfw_options = b.addOptions();
    inline for (std.meta.fields(@TypeOf(options))) |field| {
        rgfw_options.addOption(@TypeOf(@field(options, field.name)), field.name, @field(options, field.name));
    }

    const mod = b.addModule("rgfw", .{
        .root_source_file = b.path("src/rgfw.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    mod.addOptions("rgfw_options", rgfw_options);
    mod.addIncludePath(b.path("."));
    mod.addCSourceFile(.{ .file = b.path("RGFW.c") });

    // Apply C macros (for RGFW.c, the single-header C library)
    if (options.rgfw_opengl) mod.addCMacro("RGFW_OPENGL", "");
    if (options.rgfw_implementation) mod.addCMacro("RGFW_IMPLEMENTATION", "");
    if (options.rgfw_debug) mod.addCMacro("RGFW_DEBUG", "");
    if (options.rgfw_egl) mod.addCMacro("RGFW_EGL", "");
    if (options.rgfw_directx) mod.addCMacro("RGFW_DIRECTX", "");
    if (options.rgfw_vulkan) mod.addCMacro("RGFW_VULKAN", "");
    if (options.rgfw_webgpu) mod.addCMacro("RGFW_WEBGPU", "");
    if (options.rgfw_native) mod.addCMacro("RGFW_NATIVE", "");
    if (options.rgfw_x11) mod.addCMacro("RGFW_X11", "");
    if (options.rgfw_wayland) mod.addCMacro("RGFW_WAYLAND", "");
    if (options.rgfw_no_static_context) mod.addCMacro("RGFW_NO_STATIC_CONTEXT", "");
    if (options.rgfw_no_x11) mod.addCMacro("RGFW_NO_X11", "");
    if (options.rgfw_no_x11_cursor) mod.addCMacro("RGFW_NO_X11_CURSOR", "");
    if (options.rgfw_no_x11_cursor_preload) mod.addCMacro("RGFW_NO_X11_CURSOR_PRELOAD", "");
    if (options.rgfw_no_x11_ext_preload) mod.addCMacro("RGFW_NO_X11_EXT_PRELOAD", "");
    if (options.rgfw_no_x11_xi_preload) mod.addCMacro("RGFW_NO_X11_XI_PRELOAD", "");
    if (options.rgfw_no_load_winmm) mod.addCMacro("RGFW_NO_LOAD_WINMM", "");
    if (options.rgfw_no_winmm) mod.addCMacro("RGFW_NO_WINMM", "");
    if (options.rgfw_no_iokit) mod.addCMacro("RGFW_NO_IOKIT", "");
    if (options.rgfw_no_unix_clock) mod.addCMacro("RGFW_NO_UNIX_CLOCK", "");
    if (options.rgfw_no_dwm) mod.addCMacro("RGFW_NO_DWM", "");
    if (options.rgfw_use_xdl) mod.addCMacro("RGFW_USE_XDL", "");
    if (options.rgfw_cocoa_graphics_switching) mod.addCMacro("RGFW_COCOA_GRAPHICS_SWITCHING", "");
    if (options.rgfw_no_dpi) mod.addCMacro("RGFW_NO_DPI", "");
    if (options.rgfw_advanced_smooth_resize) mod.addCMacro("RGFW_ADVANCED_SMOOTH_RESIZE", "");
    if (options.rgfw_no_info) mod.addCMacro("RGFW_NO_INFO", "");
    if (options.rgfw_no_glxwindow) mod.addCMacro("RGFW_NO_GLXWINDOW", "");
    if (options.rgfw_no_allocate_monitors) mod.addCMacro("RGFW_NO_ALLOCATE_MONITORS", "");
    if (options.rgfw_no_include_vulkan) mod.addCMacro("RGFW_NO_INCLUDE_VULKAN", "");
    if (options.rgfw_use_int) mod.addCMacro("RGFW_USE_INT", "");
    if (options.rgfw_no_math) mod.addCMacro("RGFW_NO_MATH", "");
    if (options.rgfw_no_passthrough) mod.addCMacro("RGFW_NO_PASSTHROUGH", "");
    if (options.rgfw_custom_backend) mod.addCMacro("RGFW_CUSTOM_BACKEND", "");
    if (options.rgfw_libdecor) mod.addCMacro("RGFW_LIBDECOR", "");
    if (options.rgfw_x11_crash_on_error) mod.addCMacro("RGFW_X11_CRASH_ON_ERROR", "");
    if (options.rgfw_win95) mod.addCMacro("RGFW_WIN95", "");
    if (options.rgfw_c89) mod.addCMacro("RGFW_C89", "");
    if (options.rgfw_dynamic) mod.addCMacro("RGFW_DYNAMIC", "");
    if (options.rgfw_macos) mod.addCMacro("RGFW_MACOS", "");
    if (options.rgfw_macos_x11) mod.addCMacro("RGFW_MACOS_X11", "");
    if (options.rgfw_unix) mod.addCMacro("RGFW_UNIX", "");
    if (options.rgfw_wasm) mod.addCMacro("RGFW_WASM", "");
    if (options.rgfw_windows) mod.addCMacro("RGFW_WINDOWS", "");
    if (options.rgfw_cocoa_frame_name) |val| mod.addCMacro("RGFW_COCOA_FRAME_NAME", val);
    if (options.rgfw_alloc) |val| mod.addCMacro("RGFW_ALLOC", val);
    if (options.rgfw_free) |val| mod.addCMacro("RGFW_FREE", val);
    if (options.rgfw_userptr) |val| mod.addCMacro("RGFW_USERPTR", val);
    if (options.rgfw_export) |val| mod.addCMacro("RGFW_EXPORT", val);
    if (options.rgfw_import) |val| mod.addCMacro("RGFW_IMPORT", val);
    if (options.rgfw_bool_type) |val| mod.addCMacro("RGFW_bool", val);
    if (options.rgfw_assert) |val| mod.addCMacro("RGFW_ASSERT", val);
    if (options.rgfw_static_assert) |val| mod.addCMacro("RGFW_STATIC_ASSERT", val);
    if (options.rgfw_snprintf) |val| mod.addCMacro("RGFW_SNPRINTF", val);
    if (options.rgfw_printf) |val| mod.addCMacro("RGFW_PRINTF", val);
    if (options.rgfw_memzero) |val| mod.addCMacro("RGFW_MEMZERO", val);
    if (options.rgfw_memcpy) |val| mod.addCMacro("RGFW_MEMCPY", val);
    if (options.rgfw_strncmp) |val| mod.addCMacro("RGFW_STRNCMP", val);
    if (options.rgfw_strncpy) |val| mod.addCMacro("RGFW_STRNCPY", val);
    if (options.rgfw_strstr) |val| mod.addCMacro("RGFW_STRSTR", val);
    if (options.rgfw_strtol) |val| mod.addCMacro("RGFW_STRTOL", val);
    if (options.rgfw_atof) |val| mod.addCMacro("RGFW_ATOF", val);
    if (options.rgfw_round) |val| mod.addCMacro("RGFW_ROUND", val);
    if (options.rgfw_roundf) |val| mod.addCMacro("RGFW_ROUNDF", val);
    if (options.rgfw_min) |val| mod.addCMacro("RGFW_MIN", val);
    if (options.rgfw_unused) |val| mod.addCMacro("RGFW_UNUSED", val);
    if (options.rgfw_preallocated_monitors) |val| mod.addCMacro("RGFW_PREALLOCATED_MONITORS", b.fmt("{d}", .{val}));
    if (options.rgfw_max_events) |val| mod.addCMacro("RGFW_MAX_EVENTS", b.fmt("{d}", .{val}));
    if (options.rgfw_xdnd_version) |val| mod.addCMacro("RGFW_XDND_VERSION", b.fmt("{d}", .{val}));

    var example_exe = b.addExecutable(.{
        .name = "example",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/example.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    var example_install = b.addInstallArtifact(example_exe, .{});

    example_exe.root_module.addImport("rgfw", mod);
    example_exe.root_module.linkSystemLibrary("opengl32", .{});
    example_exe.root_module.linkSystemLibrary("gdi32", .{});

    var example_run = b.addRunArtifact(example_exe);

    var run_example_exe = b.step("example", "Build and run example.zig");
    run_example_exe.dependOn(&example_install.step);
    run_example_exe.dependOn(&example_run.step);
}
