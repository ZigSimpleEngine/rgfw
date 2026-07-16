const std = @import("std");

fn getEnv(allocator: std.mem.Allocator, name: []const u8) ?[]u8 {
    const environ = std.process.Environ{ .block = .{ .use_global = true } };
    var map = std.process.Environ.createMap(environ, allocator) catch return null;
    defer map.deinit();
    const value = map.get(name) orelse return null;
    return allocator.dupe(u8, value) catch return null;
}

/// Case-insensitively find a subdirectory `name` inside `dir`.
/// Returns an owned slice (caller must free) or `null` if not found.
fn findDirNameCaseless(allocator: std.mem.Allocator, io: std.Io, dir: std.Io.Dir, name: []const u8) !?[]u8 {
    var iter = dir.iterate();
    while (try iter.next(io)) |entry| {
        if (entry.kind == .directory and std.ascii.eqlIgnoreCase(entry.name, name)) {
            return try allocator.dupe(u8, entry.name);
        }
    }
    return null;
}

pub const Options = struct {
    /// Force compilation with OpenGL context creation and support
    rgfw_opengl: bool = false,
    /// Compiles with EGL context creation support, allowing you to use EGL instead of native OpenGL context functions (WGL/GLX/NSGL)
    rgfw_egl: bool = false,
    /// Enables Vulkan context creation helper functions, macros, and structure definitions
    rgfw_vulkan: bool = false,
    /// Exposes and includes DirectX integration helper functions (Windows only)
    rgfw_directx: bool = false,
    /// Enables WebGPU integration and helper context creation functions
    rgfw_webgpu: bool = false,
    /// Exposes and defines native RGFW structures and types that utilize platform_native API structures
    rgfw_native: bool = false,
    /// Prevents defining the global RGFW_info structure
    rgfw_no_info: bool = false,
    /// Disables the usage of GLXWindow for X11 OpenGL contexts
    rgfw_no_glxwindow: bool = false,
    /// Disables dynamic heap allocation of monitor info structures when the preallocated monitor storage limit is exceeded
    rgfw_no_allocate_monitors: bool = false,
    /// Disables the automatic inclusion of the vulkan/vulkan.h header, forcing the user to include it manually
    rgfw_no_include_vulkan: bool = false,
    /// Disables initializing with a static global variable context, using heap allocations instead if RGFW is not manually initialized
    rgfw_no_static_context: bool = false,
    /// Prevents fallback to X11 if Wayland is requested but is unavailable or fails
    rgfw_no_x11: bool = false,
    /// Disables Xcursor support completely under X11, falling back to standard cursors
    rgfw_no_x11_cursor: bool = false,
    /// Uses Xcursor under X11, but compiles without dynamically preloading libXcursor, requiring you to link with _lXcursor
    rgfw_no_x11_cursor_preload: bool = false,
    /// Uses Xext under X11, but compiles without dynamically preloading libXext, requiring you to link with _lXext
    rgfw_no_x11_ext_preload: bool = false,
    /// Uses XInput2 under X11, but compiles without dynamically preloading libXi, requiring you to link with _lXi
    rgfw_no_x11_xi_preload: bool = false,
    /// Uses winmm on Windows, but compiles without dynamically loading winmm.dll, requiring you to link with _lwinmm
    rgfw_no_load_winmm: bool = false,
    /// Disables winmm (and timeBeginPeriod) usage entirely under Windows
    rgfw_no_winmm: bool = false,
    /// Disables IOKit framework usage and linking on macOS
    rgfw_no_iokit: bool = false,
    /// Disables linking POSIX clock functions (clock_gettime) on Unix_like systems
    rgfw_no_unix_clock: bool = false,
    /// Disables usage and linking of Desktop Window Manager (dwmapi) library on Windows
    rgfw_no_dwm: bool = false,
    /// Disables powf and other math library functions, preventing inclusion of <math.h> for minimal systems
    rgfw_no_math: bool = false,
    /// Disables mouse passthrough functionality and excludes related APIs from compilation
    rgfw_no_passthrough: bool = false,
    /// Disables High_DPI calculations and Shcore.dll library loading/usage on Windows
    rgfw_no_dpi: bool = false,
    /// Forces the X11 backend to be used (default on Unix systems except macOS)
    rgfw_x11: bool = false,
    /// Enables compiling with the Wayland backend (Unix only, can be used concurrently with X11 for dynamic dual backend support)
    rgfw_wayland: bool = false,
    /// Enables XDL (Xlib Dynamic Loader) to dynamically load X11 functions at runtime (requires including XDL.h)
    rgfw_use_xdl: bool = false,
    /// Enables advanced methods for smooth resizing on Windows (such as WM_TIMER) and X11 (such as XSync), which might slightly impact performance or memory
    rgfw_advanced_smooth_resize: bool = false,
    /// Forces the use of standard C primitive integer types instead of <stdint.h> types
    rgfw_use_int: bool = false,
    /// Disables standard OS backend detection entirely, enabling building/linking with a custom windowing backend
    rgfw_custom_backend: bool = false,
    /// Enables libdecor support for client_side decorations on Wayland
    rgfw_libdecor: bool = false,
    /// Enables automatic graphics switching on macOS Cocoa, allowing the system to switch dynamically between integrated and discrete GPUs
    rgfw_cocoa_graphics_switching: bool = false,
    /// Disables modern Win32 calls and APIs to target Windows 95 compatibility
    rgfw_win95: bool = false,
    /// Forces compilation with C89 compatibility settings (disables stdint.h/newer features)
    rgfw_c89: bool = false,
    /// Auto_defined when using both X11 and Wayland concurrently, enabling runtime dynamic platform entry loading, but can be manually defined to configure dynamic execution behavior
    rgfw_dynamic: bool = false,
    /// Forces or indicates macOS Cocoa target platform compilation
    rgfw_macos: bool = false,
    /// Forces or indicates macOS X11 target platform compilation
    rgfw_macos_x11: bool = false,
    /// Forces or indicates Unix/Linux target platform compilation
    rgfw_unix: bool = false,
    /// Forces or indicates WebAssembly/Emscripten target platform compilation
    rgfw_wasm: bool = false,
    /// Forces or indicates Windows target platform compilation
    rgfw_windows: bool = false,
    /// Forces an assertion crash immediately when an X11 protocol error is encountered
    rgfw_x11_crash_on_error: bool = false,
    /// Sets a custom Cocoa frame name on macOS
    rgfw_cocoa_frame_name: ?[]const u8 = null,
    /// Overrides the default heap allocation function (defaults to standard malloc)
    rgfw_alloc: ?[]const u8 = null,
    /// Overrides the default deallocation function (defaults to standard free)
    rgfw_free: ?[]const u8 = null,
    /// Sets a default user pointer argument to be sent to standard allocator calls (defaults to NULL)
    rgfw_userptr: ?[]const u8 = null,
    /// Configures function declarations to be exported when building RGFW as a separate library/DLL
    rgfw_export: ?[]const u8 = null,
    /// Configures function declarations to be imported when linking against RGFW as an external library
    rgfw_import: ?[]const u8 = null,
    /// Overrides the underlying boolean type used by RGFW (defaults to u32)
    rgfw_bool_type: ?[]const u8 = null,
    /// Overrides the standard assert macro with a custom assertion macro (defaults to assert)
    rgfw_assert: ?[]const u8 = null,
    /// Overrides the macro used for compile_time static assertions
    rgfw_static_assert: ?[]const u8 = null,
    /// Overrides the default snprintf function implementation
    rgfw_snprintf: ?[]const u8 = null,
    /// Overrides the default printf function implementation (used for debug printing)
    rgfw_printf: ?[]const u8 = null,
    /// Overrides the memory zeroing function (defaults to memset with a size of 0)
    rgfw_memzero: ?[]const u8 = null,
    /// Overrides the memory copy function (defaults to memcpy)
    rgfw_memcpy: ?[]const u8 = null,
    /// Overrides the string comparison function (defaults to strncmp)
    rgfw_strncmp: ?[]const u8 = null,
    /// Overrides the string copy function (defaults to strncpy)
    rgfw_strncpy: ?[]const u8 = null,
    /// Overrides the substring search function (defaults to strstr)
    rgfw_strstr: ?[]const u8 = null,
    /// Overrides the string_to_long integer parsing function (defaults to strtol)
    rgfw_strtol: ?[]const u8 = null,
    /// Overrides the string_to_float parsing function (defaults to atof)
    rgfw_atof: ?[]const u8 = null,
    /// Overrides the custom coordinate rounding macro
    rgfw_round: ?[]const u8 = null,
    /// Overrides the custom float coordinate rounding macro
    rgfw_roundf: ?[]const u8 = null,
    /// Overrides the default minimum macro
    rgfw_min: ?[]const u8 = null,
    /// Overrides the macro used to suppress unused variable compiler warnings
    rgfw_unused: ?[]const u8 = null,
    /// Overrides the preallocated monitor buffer size to avoid dynamic heap allocation (defaults to 6)
    rgfw_preallocated_monitors: ?u32 = null,
    /// Configures the maximum number of events stored in the internal RGFW event queue (defaults to 32)
    rgfw_max_events: ?u32 = null,
    /// Overrides the default XDnD (Drag and Drop) protocol version (defaults to 5 on X11)
    rgfw_xdnd_version: ?u32 = null,
    /// Enables RGFW debug mode, printing debug messages and detailed errors when they occur
    rgfw_debug: bool = false,

    pub fn initFromOptions(b: *std.Build) Options {
        return .{
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
        };
    }

    pub fn toDependencyArgs(comptime value: Options) CompactType(value) {
        const Result = CompactType(value);

        var result: Result = undefined;

        const fields = @typeInfo(Result).@"struct".fields;

        inline for (fields) |field| {
            const v = @field(value, field.name);

            @field(result, field.name) = switch (@typeInfo(@TypeOf(v))) {
                .optional => v.?,
                else => v,
            };
        }

        return result;
    }

    fn unwrap(comptime T: type) type {
        return switch (@typeInfo(T)) {
            .optional => |o| o.child,
            else => T,
        };
    }

    fn isKeep(comptime value: anytype) bool {
        return switch (@typeInfo(@TypeOf(value))) {
            .optional => value != null,
            .bool => value,
            else => unreachable,
        };
    }

    fn CompactType(comptime value: anytype) type {
        const T = @TypeOf(value);
        const fields = @typeInfo(T).@"struct".fields;

        comptime var count = 0;
        inline for (fields) |field| {
            if (isKeep(@field(value, field.name))) {
                count += 1;
            }
        }

        comptime var names: [count][]const u8 = undefined;
        comptime var types: [count]type = undefined;
        comptime var attrs: [count]std.builtin.Type.StructField.Attributes =
            @splat(.{});

        comptime var index = 0;

        inline for (fields) |field| {
            const v = @field(value, field.name);
            if (isKeep(v)) {
                names[index] = field.name;
                types[index] = unwrap(field.type);
                attrs[index] = .{};
                index += 1;
            }
        }

        return @Struct(
            .auto,
            null,
            &names,
            &types,
            &attrs,
        );
    }
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const options = Options.initFromOptions(b);

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
    if (target.result.os.tag == .windows) {
        mod.linkSystemLibrary("opengl32", .{});
        mod.linkSystemLibrary("gdi32", .{});
        mod.linkSystemLibrary("shell32", .{});
        mod.linkSystemLibrary("user32", .{});
    } else if (target.result.os.tag == .linux) {
        if (options.rgfw_wayland) {
            mod.linkSystemLibrary("wayland-client", .{});
            mod.linkSystemLibrary("wayland-egl", .{});
            mod.linkSystemLibrary("wayland-cursor", .{});
            mod.linkSystemLibrary("xkbcommon", .{});
            mod.linkSystemLibrary("dl", .{});
        } else {
            mod.linkSystemLibrary("X11", .{});
            mod.linkSystemLibrary("Xrandr", .{});
            mod.linkSystemLibrary("m", .{});
            mod.linkSystemLibrary("dl", .{});
        }
    } else if (target.result.os.tag.isDarwin()) {
        mod.linkFramework("Cocoa", .{});
        mod.linkFramework("IOKit", .{});
    }

    // Apply C macros (for RGFW.c, the single-header C library)
    if (options.rgfw_opengl) mod.addCMacro("RGFW_OPENGL", "");
    // RGFW_IMPLEMENTATION is always defined for RGFW.c (via its own #define).
    // We do NOT define it for @cImport because the implementation section contains
    // platform-specific includes (e.g. <dlfcn.h>) that fail on Windows.
    // The 6 C functions that live inside #ifdef RGFW_IMPLEMENTATION are declared
    // as extern fn in rgfw.zig directly.
    if (options.rgfw_debug) mod.addCMacro("RGFW_DEBUG", "");
    if (options.rgfw_egl) {
        mod.addCMacro("RGFW_EGL", "");
        mod.addCMacro("RGFW_OPENGL", ""); // EGL on Windows requires nativeGL_handle (defined under RGFW_OPENGL)
        // EGL_SDK env var is required: must point to the root of an EGL implementation
        const egl_sdk = b.option([]const u8, "egl_sdk", "Path to EGL SDK root (overrides EGL_SDK env var)") orelse
            (getEnv(b.allocator, "EGL_SDK") orelse {
                std.log.err(
                    \\EGL support requires the EGL_SDK environment variable.
                    \\
                    \\RGFW with rgfw_egl needs EGL headers (EGL/egl.h) and libraries.
                    \\Set EGL_SDK to the root directory of your EGL implementation
                    \\(e.g. ANGLE, Mesa, or system EGL).
                    \\
                    \\This directory should contain:
                    \\  include/EGL/   - headers (egl.h, eglext.h, eglplatform.h)
                    \\  lib/           - EGL library (libEGL.lib, libEGL.dll.a, etc.)
                    \\
                    \\Example:
                    \\  set EGL_SDK=D:\Libs\C\angle-x64   (Windows)
                    \\  export EGL_SDK=/usr/local/angle    (Linux/macOS)
                , .{});
                @panic("EGL_SDK not configured");
            });
        // Verify the directory exists
        const egl_dir = std.Io.Dir.openDirAbsolute(b.graph.io, egl_sdk, .{ .iterate = true }) catch |err| {
            std.log.err("EGL_SDK path '{s}' does not exist or is not accessible: {s}", .{ egl_sdk, @errorName(err) });
            @panic("invalid EGL_SDK path");
        };
        defer std.Io.Dir.close(egl_dir, b.graph.io);

        // Case-insensitively find 'include' and 'lib' subdirectories
        const include_name = (findDirNameCaseless(b.allocator, b.graph.io, egl_dir, "include") catch @panic("I/O error scanning EGL_SDK")) orelse {
            std.log.err("EGL_SDK directory '{s}' does not contain an 'include' subdirectory", .{egl_sdk});
            @panic("EGL SDK missing include directory");
        };

        const lib_name = (findDirNameCaseless(b.allocator, b.graph.io, egl_dir, "lib") catch @panic("I/O error scanning EGL_SDK")) orelse {
            std.log.err("EGL_SDK directory '{s}' does not contain a 'lib' subdirectory", .{egl_sdk});
            @panic("EGL SDK missing lib directory");
        };

        const include_path = std.fs.path.join(b.allocator, &[_][]const u8{ egl_sdk, include_name }) catch @panic("OOM");
        const lib_path = std.fs.path.join(b.allocator, &[_][]const u8{ egl_sdk, lib_name }) catch @panic("OOM");

        mod.addIncludePath(.{ .cwd_relative = include_path });
        mod.addLibraryPath(.{ .cwd_relative = lib_path });
        mod.linkSystemLibrary("libEGL.dll", .{});
    }
    if (options.rgfw_directx) mod.addCMacro("RGFW_DIRECTX", "");
    if (options.rgfw_vulkan) {
        mod.addCMacro("RGFW_VULKAN", "");
        // Force Win32 platform in the Vulkan SDK headers (Aro on Windows predefines __unix__)
        mod.addCMacro("VK_USE_PLATFORM_WIN32_KHR", "");
        // VULKAN_SDK env var is required: must point to the root of a Vulkan SDK
        const vulkan_sdk = b.option([]const u8, "vulkan_sdk", "Path to Vulkan SDK root (overrides VULKAN_SDK env var)") orelse
            (getEnv(b.allocator, "VULKAN_SDK") orelse {
                std.log.err(
                    \\Vulkan support requires the VULKAN_SDK environment variable.
                    \\
                    \\RGFW with rgfw_vulkan needs Vulkan headers (vulkan/vulkan.h) and libraries.
                    \\Set VULKAN_SDK to the root directory of your Vulkan SDK installation.
                    \\
                    \\This directory should contain:
                    \\  Include/vulkan/   - headers (vulkan.h, vk_platform.h, etc.)
                    \\  Lib/              - Vulkan library (vulkan-1.lib, libvulkan.so, etc.)
                    \\
                    \\Example:
                    \\  set VULKAN_SDK=C:\VulkanSDK\1.3.xxx   (Windows)
                    \\  export VULKAN_SDK=/usr/local/vulkan   (Linux/macOS)
                , .{});
                @panic("VULKAN_SDK not configured");
            });
        // Verify the directory exists
        const vk_dir = std.Io.Dir.openDirAbsolute(b.graph.io, vulkan_sdk, .{ .iterate = true }) catch |err| {
            std.log.err("VULKAN_SDK path '{s}' does not exist or is not accessible: {s}", .{ vulkan_sdk, @errorName(err) });
            @panic("invalid VULKAN_SDK path");
        };
        defer std.Io.Dir.close(vk_dir, b.graph.io);

        // Case-insensitively find 'include' and 'lib' subdirectories
        const include_name = (findDirNameCaseless(b.allocator, b.graph.io, vk_dir, "include") catch @panic("I/O error scanning VULKAN_SDK")) orelse {
            std.log.err("VULKAN_SDK directory '{s}' does not contain an 'include' subdirectory", .{vulkan_sdk});
            @panic("Vulkan SDK missing include directory");
        };

        const lib_name = (findDirNameCaseless(b.allocator, b.graph.io, vk_dir, "lib") catch @panic("I/O error scanning VULKAN_SDK")) orelse {
            std.log.err("VULKAN_SDK directory '{s}' does not contain a 'lib' subdirectory", .{vulkan_sdk});
            @panic("Vulkan SDK missing lib directory");
        };

        const include_path = std.fs.path.join(b.allocator, &[_][]const u8{ vulkan_sdk, include_name }) catch @panic("OOM");
        const lib_path = std.fs.path.join(b.allocator, &[_][]const u8{ vulkan_sdk, lib_name }) catch @panic("OOM");

        mod.addIncludePath(.{ .cwd_relative = include_path });
        mod.addLibraryPath(.{ .cwd_relative = lib_path });
        mod.linkSystemLibrary("vulkan-1", .{});
    }
    if (options.rgfw_webgpu) {
        mod.addCMacro("RGFW_WEBGPU", "");
        mod.addIncludePath(b.path("include"));
        // Note: when using WebGPU, you must link a WebGPU implementation library
        // (e.g. wgpu_native, dawn, webgpu_dawn) yourself.
    }
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

    // Test step — reuses the rgfw module (with all C macros from above)
    const test_mod = b.createModule(.{
        .root_source_file = b.path("src/test.zig"),
        .target = target,
        .optimize = optimize,
    });
    test_mod.addImport("rgfw", mod);

    const test_step = b.addTest(.{ .root_module = test_mod });
    const test_install = b.addInstallArtifact(test_step, .{});
    const run_tests = b.addRunArtifact(test_step);
    const test_step_alias = b.step("test", "Run all tests");
    test_step_alias.dependOn(&test_install.step);
    test_step_alias.dependOn(&run_tests.step);

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

    var example_run = b.addRunArtifact(example_exe);

    var run_example_exe = b.step("example", "Build and run example.zig");
    run_example_exe.dependOn(&example_install.step);
    run_example_exe.dependOn(&example_run.step);
}
