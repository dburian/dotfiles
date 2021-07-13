-- Leader
vim.g.mapleader='\\'

-- Leader for easymotion
vim.api.nvim_set_keymap('n', '<leader>', '<Plug>(easymotion-prefix)', {noremap = true})

-- Pane navigation
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>l', {noremap = true})
vim.api.nvim_set_keymap('n', '<c-k>', '<c-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<c-j>', '<c-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w>h', {noremap = true})

vim.api.nvim_set_keymap('i', '<c-l>', '<Esc><c-w>l', {noremap = true})
vim.api.nvim_set_keymap('i', '<c-k>', '<Esc><c-w>k', {noremap = true})
vim.api.nvim_set_keymap('i', '<c-j>', '<Esc><c-w>j', {noremap = true})
vim.api.nvim_set_keymap('i', '<c-h>', '<Esc><c-w>h', {noremap = true})


-- Removing old habits
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Up>', 'ddkP', {noremap = true})
vim.api.nvim_set_keymap('n', '<Down>', 'ddp', {noremap = true})

vim.api.nvim_set_keymap('i', '<Left>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('i', '<Right>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('i', '<Up>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('i', '<Down>', '<Nop>', {noremap = true})

vim.api.nvim_set_keymap('i', '<delete>', '<nop>', {noremap = true})


-- Typing
vim.api.nvim_set_keymap('n', '<leader>U','viwUe', {noremap = true})
vim.api.nvim_set_keymap('i', '<leader>U','<esc>viwUea', {noremap = true})

-- Accessing files
--TODO: move to telescope.lua
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
  '<leader>sc',
  ':luafile ~/.config/nvim/init.lua<cr>',
  {noremap = true, silent = true}
)
