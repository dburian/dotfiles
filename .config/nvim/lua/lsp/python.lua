-- Configuration of jedi-language-server for python
-- grabbed from nvim-lspconfig

local on_attach = require('lsp').on_attach

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require'lspconfig'.jedi_language_server.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
