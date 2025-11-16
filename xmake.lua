add_rules("mode.release", "mode.debug", "mode.releasedbg")
set_policy("build.optimization.lto", true)

target("right")
    set_kind("binary")
    add_files("src/*.cpp")
    set_toolset("dsymutil", "dsymutil")

    on_load(function (target)
        target:add("ldflags", "-fuse-ld=lld", "-Wl,-dead_strip")
        target:add("ldflags", format("-Wl,-object_path_lto,%s_lto.o", target:name()))
    end)

target("error")
    set_kind("binary")
    add_files("src/*.cpp")
