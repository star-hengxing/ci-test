add_rules("mode.release", "mode.debug", "mode.releasedbg")
set_policy("build.optimization.lto", true)

target("right")
    set_kind("binary")
    add_files("src/*.cpp")
    if is_plat("macosx") then
        set_toolset("dsymutil", "dsymutil")
    end

    on_load(function (target)
        target:add("ldflags", format("-object_path_lto,%s_lto.o", target:name()))
        target:add("ldflags", "-cache_path_lto," .. target:targetdir())
    end)

target("error")
    set_kind("binary")
    add_files("src/*.cpp")
