local lsp_config = require('lspconfig')

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = require('cmp_nvim_lsp').update_capabilities(updated_capabilities)

local localSrcPath = vim.fn.expand'~/.local/src'

-- Lua
local lua_runtime_path = vim.split(package.path, ';')
table.insert(lua_runtime_path, 'lua/?.lua')
table.insert(lua_runtime_path, 'lua/?/init.lua')

-- Java
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local dataDir = vim.env.XDG_CACHE_HOME .. '/jdtls/' .. project_name
local server_install_dir = localSrcPath .. '/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository'

-- Dart
local flutter_sdk_path = '/opt/flutter/'

local servers = {
  jedi_language_server = {},

  sumneko_lua = {
    cmd = {
      localSrcPath .. '/lua-language-server/bin/Linux/lua-language-server',
      '-E',
      localSrcPath .. '/lua-language-server/main.lua',
    },
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
  },

  jdtls = {
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

  dartls = {
    init_options = {
      onlyAnalyzeProjectsWithOpenFiles = true,
      suggestFromUnimportedLibraries = true,
      closingLabels = true,
      outline = true,
      flutterOutline = true,
    },
    settings = {
      dart = {
        completeFunctionCalls = true,
        showTodos = true,
        analysisExcludedFolders = {
          flutter_sdk_path .. "packages",
          flutter_sdk_path .. ".pub-cache",
        },
      },
    },
  },

  tsserver = {},
}


local custom_attach = function(_, bufnr)
  local opts = {noremap = true, silent = true}

  --TODO: change to new-style mapping
  local bfk = function(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  end

  -- local bfo = function(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Native completion filled by lsp
  -- bfo('omnifunc', 'v:vim.lua.lsp.omnifunc')

  bfk('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  bfk('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  bfk('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')

  bfk('n', '<leader>h', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  bfk('i', '<leader>h', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  bfk('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  bfk('n', '<leader>ca', "<cmd>lua require'telescope.builtin'.lsp_code_actions()<cr>")
  bfk('n', '<leader>fs', "<cmd>lua require'telescope.builtin'.lsp_document_symbols()<cr>")

  bfk('n', '<leader>[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  bfk('n', '<leader>]d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  bfk('n', '<leader>dl', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
  bfk('n', '<leader>fo', '<cmd>lua vim.lsp.buf.formatting_sync()<CR>')

end


local setup_server = function(server, config)
  config = vim.tbl_deep_extend("force", {
    on_attach = custom_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  if lsp_config[server] == nil then
    print("Error in lsp config: config for server " .. server .. " cannot be found")
  else
    lsp_config[server].setup(config)
  end
end

for server, config in pairs(servers) do
  setup_server(server, config)
end

