local null_ls = require 'null-ls'
local helpers = require 'null-ls.helpers'
local methods = require 'null-ls.methods'
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
  -- { 'black', null_ls.builtins.formatting.black },
  { 'latexindent', null_ls.builtins.formatting.latexindent },
  { 'eslint_d', null_ls.builtins.diagnostics.eslint_d },
  {
    -- Adjusted ruff to replace black
    'ruff',
    helpers.make_builtin({
      name = "ruff(replacing black)",
      meta = {
        url = "https://github.com/charliermarsh/ruff/",
        description = "An extremely fast Python linter, written in Rust.",
      },
      method = methods.internal.FORMATTING,
      filetypes = { "python" },
      generator_opts = {
        command = "ruff",
        args = { "format", "--respect-gitignore", "--stdin-filename", "$FILENAME", "-" },
        to_stdin = true,
      },
      factory = helpers.formatter_factory,
    })
  },
  { 'ruff', null_ls.builtins.formatting.ruff.with({
        diagnostics_format = "[#{c}] #{m} (#{s})",
    }),
  },
  { 'ruff', null_ls.builtins.diagnostics.ruff.with({
        diagnostics_format = "[#{c}] #{m} (#{s})",
    }),
  },
  { 'chktex', null_ls.builtins.diagnostics.chktex },
  { 'mypy', null_ls.builtins.diagnostics.mypy.with({
        diagnostics_format = "[#{c}] #{m} (#{s})",
    }),
  },
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
