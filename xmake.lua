set_policy("package.install_locally", true)

add_requires("test")

package("test")
    set_sourcedir("src")

    on_install(function (package)
        io.writefile("xmake.lua", [[
            add_rules("mode.debug", "mode.release")
            target("test")
                set_kind("static")
                add_files("*.cpp")
        ]])
        import("package.tools.xmake").install(package)

        local abi
        local format
        if package:is_plat("windows") then
            abi = "msvc"
            format = ".7z"
        elseif package:is_plat("linux") then
            abi = "gnu"
            format = ".tar.xz"
        end
        -- arch-plat-abi-mode
        local archive_name = table.concat({
            package:arch(),
            package:plat(),
            abi,
            package:is_debug() and "debug" or "release",
        }, "-")

        local archive_file = path.join(os.scriptdir(), "build/package", archive_name .. format)

        local opt = {}
        opt.recurse = true
        opt.compress = "best"
        import("utils.archive").archive(archive_file, package:installdir(), opt)

        print(hash.sha256(archive_file))
    end)
