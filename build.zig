const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.addModule("rgfw", .{
        .root_source_file = b.path("src/rgfw.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    mod.addIncludePath(b.path("."));
    mod.addCMacro("RGFW_OPENGL", "");
    mod.addCSourceFile(.{ .file = b.path("RGFW.c") });

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
