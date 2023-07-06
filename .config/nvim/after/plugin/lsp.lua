local db_lsp = require 'db.lsp'
local lsp_config = require('lspconfig')

local localSrcPath = vim.fn.expand '~/.local/src'

-- Java
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local dataDir = vim.env.XDG_CACHE_HOME .. '/jdtls/' .. project_name
local server_install_dir = localSrcPath .. '/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository'

-- Lua
local lua_runtime_path = vim.split(package.path, ';')
table.insert(lua_runtime_path, 'lua/?.lua')
table.insert(lua_runtime_path, 'lua/?/init.lua')

local servers = {
  ccls = {
    ctags_fallback = true,
    config = {
      init_options = {
        compilationDatabaseDirectory = "build",
        index = {
          threads = 1,
        },
        clang = {
          excludeArgs = { "-frounding-math" },
        },
      },
    }
  },
  jdtls = {
    ctags_fallback = true,
    config = {
      cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', server_install_dir .. '/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-configuration', server_install_dir .. '/config_linux',
        '-data', dataDir
      }
    },
  },
  svelte = {},
  tsserver = {},
  pyright = {
    ctags_fallback = true,
  },
  lua_ls = {
    config = {
      cmd = {
        localSrcPath .. '/lua-language-server/bin/lua-language-server',
      },
      settings = {
        Lua = {
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
            }
          },
          runtime = {
            version = 'LuaJIT',
            path = lua_runtime_path,
          },
          diagnostics = {
            globals = { 'vim', 'P', 'db' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file('', true),
          },
          telemetry = {
            -- Do not send data
            enable = false,
          }
        }
      },
    }
  },
  texlab = {ctags_fallback = true},
  hls = {},
}

for server, spec in pairs(servers) do
  db_lsp.setup_language_server(server, spec)
end
