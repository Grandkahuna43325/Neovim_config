local home = os.getenv("HOME")
local jdtls = require("jdtls")

local root_markers = { "gradlew", "mvnw", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)

local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

function nnoremap(rhs, lhs, bufopts, desc)
    bufopts.desc = desc
    vim.keymap.set("n", rhs, lhs, bufopts)
end

local on_attach = require("plugins.configs.lsp.on_attach")
local launcher_jar =
    vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")

local config_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_linux"

local config = {
    flags = {
        debounce_text_changes = 80,
    },
    on_attach = on_attach, -- We pass our on_attach keybindings to the configuration map
    root_dir = root_dir, -- Set the root directory to our found root_marker
    settings = {
        java = {
            gradle = {
                enabled = true,
                wrapper = {
                    enabled = true,
                },
                version = "8.5", -- or your Gradle version
            },

            -- Auto-resolve dependencies
            dependencies = {
                gradle = {
                    enabled = true,
                    downloadSources = true,
                },
            },

            importGradle = {
                enabled = true,
                offline = false, -- Set to true if you want offline mode
            },
            format = {
                settings = {
                    url = "/.local/share/eclipse/eclipse-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" }, -- Use fernflower to decompile library code
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
            },
            -- Specify any options for organizing imports
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            -- How code generation should act
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
            -- If you are developing in projects with different Java versions, you need
            -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            -- And search for `interface RuntimeOption`
            -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-21",
                        path = "/home/grandkahuna43325/.nix-profile/bin/java",
                    },
                },
            },
        },
    },
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx4g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        -- The jar file is located where jdtls was installed. This will need to be updated
        -- to the location where you installed jdtls
        "-jar",
        launcher_jar,

        -- The configuration for jdtls is also placed where jdtls was installed. This will
        -- need to be updated depending on your environment
        "-configuration",
        config_dir,

        -- Use the workspace_folder defined above to store data for this project
        "-data",
        workspace_folder,
    },
}

jdtls.start_or_attach(config)

-- local jdtls = require("jdtls")
-- local home = os.getenv("HOME")
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "java",
--     callback = function()
--         local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
--         local root_dir = require("jdtls.setup").find_root(root_markers)
--         if not root_dir then
--             return
--         end
--
--         local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
--         local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name
--
--         local launcher_jar = vim.fn.glob(
--             vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
--         )
--         local config_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_linux"
--         local java_home = vim.fn.expand("$JAVA_HOME")
--         local java = java_home .. "/bin/java"
--         if vim.fn.executable(java) == 0 then
--             vim.notify("Java not found in JAVA_HOME", vim.log.levels.ERROR)
--             return
--         end
--
--         local config = {
--             cmd = {
--                 java,
--                 "-Declipse.application=org.eclipse.jdt.ls.core.id1",
--                 "-Dosgi.bundles.defaultStartLevel=4",
--                 "-Declipse.product=org.eclipse.jdt.ls.core.product",
--                 "-Xmx1g",
--                 "--add-modules=ALL-SYSTEM",
--                 "--add-opens",
--                 "java.base/java.util=ALL-UNNAMED",
--                 "--add-opens",
--                 "java.base/java.lang=ALL-UNNAMED",
--                 "-jar",
--                 launcher_jar,
--                 "-configuration",
--                 config_dir,
--                 "-data",
--                 workspace_dir,
--             },
--             root_dir = root_dir,
--             settings = { java = {} },
--             -- on_attach = lsp.on_attach,
--             -- capabilities = lsp.capabilities,
--         }
--
--         jdtls.start_or_attach(config)
--     end,
-- })
