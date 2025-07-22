add_requires("python >=3.12")

target("test")
    set_kind("binary")
    add_files("src/*.cpp")
