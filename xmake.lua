add_requires("tbox")

target("test")
    set_kind("binary")
    add_files("src/*.cpp")
