local nmap = require 'db.keymap'.nmap

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

function M.ctags_attach()
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

  -- TODO: Should be probably defined per server
  filetype_attach[filetype]()
end

function M.ls_attach(_, _)
  local opts = { noremap = true, silent = true, buffer = 0 }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, opts)


  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('i', '<leader>s', vim.lsp.buf.signature_help, opts)

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>fs', function()
    require 'telescope.builtin'.lsp_document_symbols()
  end, opts)

  vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump({ count = -1 })
  end, opts)
  vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump({ count = 1 })
  end, opts)
  vim.keymap.set('n', '<leader>dl', vim.diagnostic.setqflist, opts)
  vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, opts)


  local filetype = vim.api.nvim_get_option_value('filetype', { buf = 0 })
  filetype_attach[filetype]()
end

M.updated_capabilities = vim.lsp.protocol.make_client_capabilities()
M.updated_capabilities = require('cmp_nvim_lsp').default_capabilities(M.updated_capabilities)

local buf_enter_ft = vim.api.nvim_create_augroup('buf_enter_ft', { clear = true })
local function set_ctags_mappings_on_buf_enter(fts)
  vim.api.nvim_clear_autocmds { buffer = 0, group = buf_enter_ft }
  vim.api.nvim_create_autocmd("FileType", {
    pattern = fts,
    callback = M.ctags_attach,
  })
end

local get_no_args_command = function(server, config)
  local cmd_no_args = config.cmd
  if type(cmd_no_args) == 'table' then
    cmd_no_args = cmd_no_args[1]
  else
    vim.notify("Unknown type of command: " .. cmd_no_args, vim.log.levels.ERROR)
    return
  end

  return cmd_no_args
end

function M.fallback_to_uv(server, config)
  config = vim.tbl_deep_extend('force', vim.lsp.config[server], config or {})
  local cmd_no_args = get_no_args_command(server, config)

  if cmd_no_args == nil then
    return nil
  end

  if vim.fn.executable(cmd_no_args) == 0 and vim.fn.executable('uv') == 1 then
    local uv_cmd = { 'uv', 'run' }
    if type(config.cmd) == 'table' then
      for _, cmd_crumb in ipairs(config.cmd) do
        table.insert(uv_cmd, cmd_crumb)
      end
    else
      vim.notify("Unknown type of command: " .. cmd_no_args, vim.log.levels.ERROR)
      return nil
    end

    return uv_cmd
  end

  return config.cmd
end

function M.enable_or_ctags(server, config)
  config = vim.tbl_deep_extend('force', vim.lsp.config[server], config or {})

  local cmd_no_args = get_no_args_command(server, config)

  if cmd_no_args == nil or vim.fn.executable(cmd_no_args) == 0 then
    set_ctags_mappings_on_buf_enter(config.filetypes)
  else
    vim.lsp.config(server, config)
    vim.lsp.enable(server, true)
  end
end

return M
