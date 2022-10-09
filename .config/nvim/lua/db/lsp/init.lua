local lsp_config = require('lspconfig')
local nmap = require 'db.keymap'.nmap
local imap = require 'db.keymap'.imap

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = require('cmp_nvim_lsp').update_capabilities(updated_capabilities)

local localSrcPath = vim.fn.expand '~/.local/src'

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

local augroup_format = vim.api.nvim_create_augroup('augroup_format', { clear = true })
local function format_on_save(filter)
  vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = 0,
    callback = function()
      vim.lsp.buf.format { async = false, filter = filter }
    end,
  })
end

local filetype_attach = setmetatable({
  lua = function()
    format_on_save()
  end,
  python = function()
    format_on_save()
  end,
  javascript = function()
    format_on_save(function(client)
      return client.name ~= 'tsserver'
    end)
  end,
  typescript = function()
    format_on_save(function(client)
      return client.name ~= 'tsserver'
    end)
  end,
}, {
  __index = function(_, _)
    return function() end
  end
})

local servers = {
  pyright = {
    settings = {
      python = {
        venvPath = "/home/dburian/.local/share/python-venvs",
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          -- useLibraryCodeForTypes = true
        }
      }
    }
  },

  sumneko_lua = {
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
          globals = { 'vim', 'P', },
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
  svelte = {},
}

local M = {}

M.custom_attach = function(_, _)
  local opts = { noremap = true, silent = true, buffer = 0 }

  nmap({ 'gd', vim.lsp.buf.definition, opts })
  nmap({ 'gD', vim.lsp.buf.declaration, opts })
  nmap({ 'gT', vim.lsp.buf.type_definition, opts })

  nmap({ '<leader>gr', vim.lsp.buf.references, opts })
  nmap({ '<leader>gi', vim.lsp.buf.implementation, opts })

  nmap({ 'K', vim.lsp.buf.hover, opts })
  imap({ '<leader>s', vim.lsp.buf.signature_help, opts })

  nmap({ '<leader>rn', vim.lsp.buf.rename, opts })
  nmap({ '<leader>ca', function()
    require 'telescope.builtin'.lsp_code_actions()
  end, opts })
  nmap({ '<leader>fs', function()
    require 'telescope.builtin'.lsp_document_symbols()
  end, opts })

  nmap({ '[d', vim.diagnostic.goto_prev, opts })
  nmap({ ']d', vim.diagnostic.goto_next, opts })
  nmap({ '<leader>dl', vim.diagnostic.setloclist, opts })
  nmap({ '<leader>fo', vim.lsp.buf.format, opts })


  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
  filetype_attach[filetype]()
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

return M
