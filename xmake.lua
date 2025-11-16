add_rules("mode.release", "mode.debug", "mode.releasedbg")

target("right")
    set_kind("binary")
    add_files("src/*.cpp")
    set_toolset("dsymutil", "dsymutil")

target("error")
    set_kind("binary")
    add_files("src/*.cpp")
