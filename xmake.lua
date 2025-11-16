add_rules("mode.release", "mode.debug", "mode.releasedbg")
set_policy("build.optimization.lto", true)

target("right")
    set_kind("binary")
    add_files("src/*.cpp")
    set_toolset("dsymutil", "dsymutil")

target("error")
    set_kind("binary")
    add_files("src/*.cpp")
