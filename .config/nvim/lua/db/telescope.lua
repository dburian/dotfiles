-- Configuration of telescope plugin

local fb_actions = require "telescope".extensions.file_browser.actions

require('telescope').setup {
  defaults = require'telescope.themes'.get_ivy(),
  pickers = {
  },
  extensions = {
    file_browser = {
      mappings = {
        ["n"] = {
          ["<leader>n"] = fb_actions.create,
          ["<leader>c"] = fb_actions.copy,
          ["<leader>m"] = fb_actions.rename,
          ["<leader>d"] = fb_actions.remove,
          ["-"] = fb_actions.goto_parent_dir,
        },
      },
    },
  },
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

vim.keymap.set(
  'n',
  '<leader>fd',
  function()
    require("telescope.builtin").git_files({
      cwd = "~/Documents/dotfiles",
      prompt_title = "Dotfiles",
    })
  end,
  {noremap = true, silent = true}
)
vim.keymap.set(
  'n',
  '<leader>fg',
  -- TODO: If there is no git repo, just find files in current directory
  require("telescope.builtin").git_files,
  {noremap = true, silent = true}
)

vim.keymap.set(
  'n',
  '<leader>fb',
  require("telescope.builtin").buffers,
  {noremap = true, silent = true}
)
vim.keymap.set(
  'n',
  '<leader>fl',
  require("telescope.builtin").live_grep,
  {noremap = true, silent = true}
)
vim.keymap.set(
  'n',
  '<leader>ft',
  function ()
    require("telescope").extensions.file_browser.file_browser({
      path = vim.fn.expand("%:p:h")
    })
  end,
  {noremap = true, silent = true}
)
vim.keymap.set(
  'n',
  '<leader>fp',
  function ()
    require('telescope.builtin').find_files{
      cwd = '~/.local/share/nvim/bundle/'
    }
  end,
  {noremap = true, silent = true}
)
vim.keymap.set(
  'n',
  '<leader>fh',
  require("telescope.builtin").help_tags,
  {noremap = true, silent = true}
)
