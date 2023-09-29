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

local is_exec = function(prg)
  return vim.fn.executable(prg) == 1
end

local source_configs = {
  { 'black', null_ls.builtins.formatting.black },
  { 'latexindent', null_ls.builtins.formatting.latexindent },
  { 'eslint_d', null_ls.builtins.diagnostics.eslint_d },
  { 'ruff', null_ls.builtins.formatting.ruff },
  { 'ruff', null_ls.builtins.diagnostics.ruff },
  -- Superseded by ruff
  -- { 'isort', null_ls.builtins.formatting.isort },
  -- { 'pylint', null_ls.builtins.diagnostics.pylint.with({
  --   diagnostics_postprocess = function(diagnostic)
  --     diagnostic.message = '[' .. diagnostic.symbol .. ']: ' .. diagnostic.message
  --   end,
  --   extra_args = function()
  --     -- Set by 'activating' the virtual environment
  --     local venv = vim.env.VIRTUAL_ENV
  --     if venv == nil then
  --       return {}
  --     end

  --     local site_packages_path = vim.fn.glob(venv .. '/lib/*/site-packages/')
  --     local root_path = find_project_root(vim.fn.expand('%:p'))

  --     local extra_sys_paths = { site_packages_path }
  --     if root_path ~= nil then
  --       table.insert(extra_sys_paths, root_path)
  --     end

  --     local append_str = ''
  --     for _, path in ipairs(extra_sys_paths) do
  --       append_str = append_str .. 'sys.path.append("' .. path .. '"); '
  --     end

  --     -- Pylint runs in different process (I guess) so it does not know about
  --     -- activated virtual environments as nvim does. Adding site-packages to
  --     -- path overcomes this issue.
  --     return {
  --       '--rcfile', '~/.config/pylint/config.toml',
  --       '--py-version', python_helpers.get_python_version(),
  --       '--init-hook', 'import sys; ' .. append_str,
  --     }
  --   end
  -- }) },
  { 'chktex', null_ls.builtins.diagnostics.chktex },
  { 'mypy', null_ls.builtins.diagnostics.mypy },
}

local sources = {}

for _, s_conf in ipairs(source_configs) do
  if is_exec(s_conf[1]) then
    table.insert(sources, s_conf[2])
  end
end


null_ls.setup {
  on_attach = lsp.custom_attach,
  sources = sources,
}
