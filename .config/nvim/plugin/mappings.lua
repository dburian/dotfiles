local nmap = require 'db.keymap'.nmap
local imap = require 'db.keymap'.imap
local vmap = require 'db.keymap'.vmap

-- Leader
vim.g.mapleader = ','

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

-- Modes
imap({ 'kj', '<esc>', { noremap = true } })

-- Redefining defaults
nmap({ 'Y', 'y$', { noremap = true } })

-- Typing
nmap({ '<esc>', ':noh<cr>', { noremap = true } })
-- nmap({ '<leader>U', 'viwUe', { noremap = true } })
-- imap({ '<leader>U', '<esc>viwUea', { noremap = true } })

-- Moving lines
nmap({ '<Up>', ':m .-2<cr>==', { noremap = true } })
nmap({ '<Down>', ':m +1<cr>==', { noremap = true } })
vmap({ '<Up>', ":m '<-2<cr>gv=gv", { noremap = true } })
vmap({ '<Down>', ":m '>+1<cr>gv=gv", { noremap = true } })

nmap({ '<leader><leader>s', ':w<cr>:source %<cr>', { noremap = true } })
