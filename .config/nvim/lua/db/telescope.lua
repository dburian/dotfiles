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

vim.api.nvim_set_keymap(
  'n',
  '<leader>fd',
  ':lua require("telescope.builtin").git_files({cwd = "~/Documents/dotfiles", prompt_title = "Dotfiles"})<CR>',
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>fg',
  ':lua require("telescope.builtin").git_files()<cr>',
  {noremap = true, silent = true}
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>fb',
  ':lua require("telescope.builtin").buffers()<cr>',
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>fl',
  ':lua require("telescope.builtin").live_grep()<cr>',
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>ft',
  ':lua require("telescope").extensions.file_browser.file_browser({path = vim.fn.expand("%:p:h")})<cr>',
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>fh',
  ':lua require("telescope.builtin").help_tags()<cr>',
  {noremap = true, silent = true}
)
