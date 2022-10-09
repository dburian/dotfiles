local null_ls = require 'null-ls'
local lsp = require 'db.lsp'

null_ls.setup {
  on_attach = lsp.custom_attach,
  sources = {
    -- Formatting
    -- null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.black,

    -- Diagnostics
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.pylint.with({
      extra_args = { '--rcfile', '~/.config/pylint/config.toml' }
    })
  }
}
