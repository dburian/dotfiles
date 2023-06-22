local null_ls = require 'null-ls'
local lsp = require 'db.lsp'
local python_helpers = require 'db.python_helpers'

local find_project_root = require 'lspconfig'.util.root_pattern({
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
  '.git',
  --added by me, to be able to use scripts without creating a package with
  --`python -m path.from.root.to.module.file` to run file.py inside
  --path/from/root/to/module/file.py. Given file.py then can use scripts
  --with imports like so:
  --`from path.from.root.to.different_module.utils import super_useful_function`
})

local sources = {
  null_ls.builtins.formatting.black.with({
    extra_args = { '--preview' } -- enable comment wrapping
  }),
}

if db.opts.resources >= 2 then
  local extra_sources = {
    -- Formatting
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.latexindent,

    -- Diagnostics
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.pylint.with({
      diagnostics_postprocess = function(diagnostic)
        diagnostic.message = '[' .. diagnostic.symbol .. ']: ' .. diagnostic.message
      end,
      extra_args = function()
        -- Set by 'activating' the virtual environment
        local venv = vim.env.VIRTUAL_ENV
        if venv == nil then
          return {}
        end

        local site_packages_path = vim.fn.glob(venv .. '/lib/*/site-packages/')
        local root_path = find_project_root(vim.fn.expand('%:p'))

        local extra_sys_paths = { site_packages_path }
        if root_path ~= nil then
          table.insert(extra_sys_paths, root_path)
        end

        local append_str = ''
        for _, path in ipairs(extra_sys_paths) do
          append_str = append_str .. 'sys.path.append("' .. path .. '"); '
        end

        -- Pylint runs in different process (I guess) so it does not know about
        -- activated virtual environments as nvim does. Adding site-packages to
        -- path overcomes this issue.
        return {
          '--rcfile', '~/.config/pylint/config.toml',
          '--py-version', python_helpers.get_python_version(),
          '--init-hook', 'import sys; ' .. append_str,
        }
      end
    }),
    null_ls.builtins.diagnostics.chktex
  }

  for _, extra_source in ipairs(extra_sources) do
    table.insert(sources, extra_source)
  end
end

null_ls.setup {
  on_attach = lsp.custom_attach,
  sources = sources,
}
