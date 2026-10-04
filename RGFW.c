#define RGFW_IMPLEMENTATION

#include "RGFW.h"
// MSAA/WGL fix: proper WGL_SAMPLE_BUFFERS_ARB/WGL_SAMPLES_ARB pixel format
// request + lazy load of WGL ARB procs on first window (RGFW_loadGL runs
// before Win32 class registration, so wglChoosePixelFormatARB etc. would
// otherwise stay NULL and MSAA/modern-context/vsync silently break).
