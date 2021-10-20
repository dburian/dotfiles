-- Configuration of lua-language-server
-- all grabed from nvim-lspconfig

local on_attach = require('lsp').on_attach

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lua_runtime_path = vim.split(package.path, ';')
table.insert(lua_runtime_path, 'lua/?.lua')
table.insert(lua_runtime_path, 'lua/?/init.lua')

-- The server needs to create dirs, ergo it must be under /home/dburian
-- (originally tried to install it under /usr/local/src)
local server_src_path = '/home/dburian/.local/src/lua-language-server'
local server_bin = server_src_path .. '/bin/Linux/lua-language-server'
local main_script_path = server_src_path .. '/main.lua'

-- configured for use with neovim
require'lspconfig'.sumneko_lua.setup{
  cmd = {server_bin, '-E', main_script_path},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = lua_runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
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
  on_attach = on_attach,
  capabilities = capabilities,
}
