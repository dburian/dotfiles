local db_lsp = require 'db.lsp'

-- Lua
local lua_runtime_path = vim.split(package.path, ';')
table.insert(lua_runtime_path, 'lua/?.lua')
table.insert(lua_runtime_path, 'lua/?/init.lua')

local config = {
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
  on_attach = db_lsp.ls_attach,
  capabilities = db_lsp.updated_capabilities,
  flags = {
    debounce_text_changes = nil,
  }
}

vim.lsp.config('lua_ls', config)
vim.lsp.enable('lua_ls')
