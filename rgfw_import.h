// Wrapper for including RGFW.h from Zig's @cImport.
// Workarounds for Aro C translator quirks on Windows:
//   - Aro predefines __unix__ on Windows, which causes RGFW.h to auto-detect X11
//     and (when RGFW_VULKAN is defined) define VK_USE_PLATFORM_XLIB_KHR, pulling in
//     X11 headers that don't exist on Windows. We undefine __unix__ to prevent this.
#if defined(_WIN32) && defined(__unix__)
#undef __unix__
#endif

#include "RGFW.h"
