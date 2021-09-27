-- Configuration of telescope plugin

require('telescope').setup{}

require('telescope').load_extension('fzf')

vim.api.nvim_set_keymap(
  'n',
  '<leader>fd',
  ':lua require("telescope.builtin").git_files({cwd = "~/Documents/dotfiles", hidden = true})<CR>',
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>fg',
  ':lua require("telescope.builtin").git_files({hidden = true})<cr>',
  {noremap = true, silent = true}
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>b',
  ':lua require("telescope.builtin").file_browser({hidden = true})<cr>',
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>lg',
  ':lua require("telescope.builtin").live_grep()<cr>',
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>c',
  ':lua require"telescope.builtin".commands()<cr>',
  {noremap = true, silent = true}
)
