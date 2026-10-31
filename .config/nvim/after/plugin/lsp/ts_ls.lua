local db_lsp = require 'db.lsp'

vim.lsp.config('ts_ls', {
  on_attach = db_lsp.ls_attach,
  capabilities = db_lsp.updated_capabilities,
})

vim.lsp.enable('ts_ls', true)
