local map = vim.api.nvim_set_keymap

-- Leader
vim.g.mapleader = ','

-- Quickfix navigation
map('n', '<c-k>', ':cprev<cr>', {noremap = true})
map('n', '<c-j>', ':cnext<cr>', {noremap = true})


-- Removing old habits
map('n', '<Left>', '<Nop>', {noremap = true})
map('n', '<Right>', '<Nop>', {noremap = true})


map('i', '<Left>', '<Nop>', {noremap = true})
map('i', '<Right>', '<Nop>', {noremap = true})
map('i', '<Up>', '<Nop>', {noremap = true})
map('i', '<Down>', '<Nop>', {noremap = true})

map('i', '<esc>', '<nop>', {noremap = true})

map('i', '<delete>', '<nop>', {noremap = true})

-- Modes
map('i', 'kj', '<esc>', {noremap = true})

-- Redefining defaults
map('n', 'Y', 'y$', {noremap = true})

-- Typing
map('n', '<esc>', ':noh<cr>', {noremap = true})
map('n', '<leader>U','viwUe', {noremap = true})
map('i', '<leader>U','<esc>viwUea', {noremap = true})

-- Moving lines
map('n', '<Up>', ':m .-2<cr>==', {noremap = true})
map('n', '<Down>', ':m +1<cr>==', {noremap = true})
map('v', '<Up>', ":m '<-2<cr>gv=gv", {noremap = true})
map('v', '<Down>', ":m '>+1<cr>gv=gv", {noremap = true})

-- Accessing files

-- Develop
map(
  'n',
  '<leader>sc',
  ':lua reload_config()<cr>',
  {noremap = true, silent = true}
)

map('n', '<leader><leader>s', ':w<cr>:source %<cr>', {noremap = true})

