local lsp_config = require('lspconfig')
local nmap = require 'db.keymap'.nmap
local imap = require 'db.keymap'.imap


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


local M = {}

function M.custom_attach(_, _)
  local opts = { noremap = true, silent = true, buffer = 0 }

  nmap({ 'gd', vim.lsp.buf.definition, opts })
  nmap({ 'gD', vim.lsp.buf.declaration, opts })
  nmap({ 'gT', vim.lsp.buf.type_definition, opts })

  nmap({ 'gr', vim.lsp.buf.references, opts })
  nmap({ 'gi', vim.lsp.buf.implementation, opts })

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
  nmap({ '<leader>dl', vim.diagnostic.setqflist, opts })
  nmap({ '<leader>fo', vim.lsp.buf.format, opts })


  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
  filetype_attach[filetype]()
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = require('cmp_nvim_lsp').default_capabilities(updated_capabilities)

function M.setup_server(server, config)
  if type(config) == "function" then
    config = config()
  end

  config = vim.tbl_deep_extend("force", {
    on_attach = M.custom_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  if lsp_config[server] == nil then
    print("Error in lsp config: config for server " .. server .. " cannot be found")
    return
  end

  lsp_config[server].setup(config)
end

return M
