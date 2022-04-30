local null_ls = require'null-ls'

null_ls.setup{
  sources = {
    -- Formatting
    null_ls.builtins.formatting.autopep8,

    -- Diagnostics
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.pylint
  }
}
