local db_lsp = require 'db.lsp'

local config = {
  init_options = {
    compilationDatabaseDirectory = "build",
    index = {
      threads = 1,
    },
    clang = {
      excludeArgs = { "-frounding-math" },
    },
  },
  on_attach = db_lsp.ls_attach,
  capabilities = db_lsp.updated_capabilities,
  flags = {
    debounce_text_changes = nil,
  }
}


db_lsp.enable_or_ctags('ccls', config)
