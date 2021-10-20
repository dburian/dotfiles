-- Configuration of java lsp server

local on_attach = require('lsp').on_attach

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


local server_bin = '/home/dburian/.local/src/java-language-server/dist/lang_server_linux.sh'

require'lspconfig'.java_language_server.setup{
  cmd = {server_bin},
  on_attach = on_attach,
  capabilities = capabilities,
}
