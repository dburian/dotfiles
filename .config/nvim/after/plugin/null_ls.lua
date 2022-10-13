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
      diagnostics_postprocess = function(diagnostic)
        diagnostic.code = diagnostic.message_id
        diagnostic.message = '[' .. diagnostic.code .. ']: ' .. diagnostic.message
      end,
      extra_args = function()
        -- Set by 'activating' the virtual environment
        local venv = vim.env.VIRTUAL_ENV
        local site_packages_path = vim.fn.glob(venv .. '/lib/*/site-packages/')

        -- Pylint runs in different process (I guess) so it does not know about
        -- activated virtual environments as nvim does. Adding site-packages to
        -- path overcomes this issue.
        return {
          '--rcfile', '~/.config/pylint/config.toml',
          '--init-hook', 'import sys; sys.path.append("' .. site_packages_path .. '");',
        }
      end
    })
  }
}
