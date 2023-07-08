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

function M.custom_ctags_attach()
  vim.notify("Using ctags for current buffer.", vim.log.levels.INFO)
  local opts = { noremap = true, silent = true, buffer = 0 }

  nmap({
    'gd',
    function()
      require 'db.telescope'.telescope_tag_select({ search_cword = true, fname_width = 40 })
    end,
    opts
  })

  nmap({ 'gr', function()
    require 'telescope.builtin'.grep_string()
  end, opts })

  -- Clever substitute
  -- nmap({ '<leader>rn', , opts })
  nmap({ '<leader>fs', function()
    require 'telescope.builtin'.current_buffer_tags()
  end, opts })

  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
  filetype_attach[filetype]()
end

function M.custom_ls_attach(_, _)
  local opts = { noremap = true, silent = true, buffer = 0 }

  nmap({ 'gd', vim.lsp.buf.definition, opts })
  nmap({ 'gD', vim.lsp.buf.declaration, opts })
  nmap({ 'gT', vim.lsp.buf.type_definition, opts })

  nmap({ 'gr', vim.lsp.buf.references, opts })
  nmap({ 'gi', vim.lsp.buf.implementation, opts })

  nmap({ 'K', vim.lsp.buf.hover, opts })
  imap({ '<leader>s', vim.lsp.buf.signature_help, opts })

  nmap({ '<leader>rn', vim.lsp.buf.rename, opts })
  nmap({ '<leader>ca', vim.lsp.buf.code_action, opts })
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

local buf_enter_ft = vim.api.nvim_create_augroup('buf_enter_ft', { clear = true })
local function set_ctags_mappings_on_buf_enter(fts)
  vim.api.nvim_clear_autocmds { buffer = 0, group = buf_enter_ft }
  vim.api.nvim_create_autocmd("FileType", {
    buffer = 0,
    pattern = fts,
    callback = M.custom_ctags_attach,
  })
end

function M.setup_language_server(server, spec)
  if lsp_config[server] == nil then
    vim.notify(
      "Error in lsp config: config for server " .. server .. " cannot be found",
      vim.log.levels.ERROR
    )
    return
  end

  local config = spec.config or {}
  if type(config) == "function" then
    config = config()
  end

  config = vim.tbl_deep_extend("force", {
    on_attach = M.custom_ls_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  local cmd_no_args = config.cmd or lsp_config[server].document_config.default_config.cmd
  if type(cmd_no_args) == 'table' then
    cmd_no_args = cmd_no_args[1]
  elseif type(cmd_no_args) == 'string' then
    cmd_no_args = vim.fn.split(cmd_no_args, ' ')[1]
  else
    vim.notify("Unknown type of command: " .. cmd_no_args, vim.log.levels.ERROR)
    return
  end

  if vim.fn.executable(cmd_no_args) == 0 and spec.ctags_fallback then
    set_ctags_mappings_on_buf_enter(lsp_config[server].filetypes)
  else
    lsp_config[server].setup(config)
  end
end

return M
