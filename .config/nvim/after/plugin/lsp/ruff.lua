local db_lsp = require 'db.lsp'


local cmd = db_lsp.fallback_to_uv('ruff', {})

local config = {
  cmd = cmd,
  on_attach = db_lsp.ls_attach,
  capabilities = db_lsp.updated_capabilities,
  flags = {
    debounce_text_changes = nil,
  }
}

vim.lsp.config('ruff', config)
vim.lsp.enable('ruff', true)
