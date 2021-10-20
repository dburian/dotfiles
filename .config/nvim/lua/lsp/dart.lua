-- Configuration of dart ls installed with flutter

local on_attach = require('lsp').on_attach

local flutter_sdk_path = '/opt/flutter/'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

require'lspconfig'.dartls.setup{
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
  on_attach = on_attach,
  capabilities = capabilities,
}
