vim.g.slime_target = "tmux"
vim.g.slime_paste_file = vim.fn.tempname()
vim.g.slime_default_config = { socket_name = "default", target_pane = "{next}" }
vim.g.slime_no_mappings = 1

vim.keymap.set('n', '<leader>cc', '<Plug>SlimeLineSend')
vim.keymap.set('n', '<leader>c', '<Plug>SlimeMotionSend')
vim.keymap.set('x', '<leader>c', '<Plug>SlimeRegionSend')
