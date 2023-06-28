local nmap = require 'db.keymap'.nmap
local imap = require 'db.keymap'.imap
local vmap = require 'db.keymap'.vmap
local xmap = require 'db.keymap'.xmap


-- Quickfix navigation
nmap({ '<c-k>', ':cprev<cr>', { noremap = true } })
nmap({ '<c-j>', ':cnext<cr>', { noremap = true } })
nmap({ '<c-q>', ':ccl<cr>', { noremap = true } })


-- Removing old habits
nmap({ '<Left>', '<Nop>', { noremap = true } })
nmap({ '<Right>', '<Nop>', { noremap = true } })

imap({ '<Left>', '<Nop>', { noremap = true } })
imap({ '<Right>', '<Nop>', { noremap = true } })
imap({ '<Up>', '<Nop>', { noremap = true } })
imap({ '<Down>', '<Nop>', { noremap = true } })
imap({ '<esc>', '<nop>', { noremap = true } })
imap({ '<delete>', '<nop>', { noremap = true } })
nmap({'Q', '<nop>', {noremap = true}})

-- Modes
imap({ 'kj', '<esc>', { noremap = true } })

-- Redefining defaults
nmap({ 'Y', 'y$', { noremap = true } })
nmap({ 'J', 'mzJ`z', {noremap =true}})


-- Typing
nmap({ '<esc>', ':noh<cr>', { noremap = true } })
-- nmap({ '<leader>U', 'viwUe', { noremap = true } })
-- imap({ '<leader>U', '<esc>viwUea', { noremap = true } })
nmap({'<leader>r', '<Plug>ReplaceWithRegisterOperator', {noremap = true}})
nmap({'<leader>rr', '<Plug>ReplaceWithRegisterLine', {noremap = true}})
xmap({'<leader>r', '<Plug>ReplaceWithRegisterVisual', {noremap = true}})


-- Moving around
nmap({'<C-d>', '<C-d>zz', {noremap = true}})
nmap({'<C-u>', '<C-u>zz', {noremap = true}})
nmap({'n', 'nzzzv', {noremap = true}})
nmap({'N', 'Nzzzv', {noremap = true}})


-- Moving lines
nmap({ '<Up>', ':m .-2<cr>==', { noremap = true } })
nmap({ '<Down>', ':m +1<cr>==', { noremap = true } })
vmap({ '<Up>', ":m '<-2<cr>gv=gv", { noremap = true } })
vmap({ '<Down>', ":m '>+1<cr>gv=gv", { noremap = true } })

nmap({ '<leader><leader>s', ':w<cr>:source %<cr>', { noremap = true } })
