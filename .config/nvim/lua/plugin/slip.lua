config_require'slip'.setup{
  slips = {
    main = {
      name = 'Main',
      path = '/home/dburian/Documents/wiki',
    },
    slip = {
      name = 'Slip logs',
      path = '/home/dburian/Documents/Slip.nvim/logs',
    }
  },
  default_slip = 'main',
}

vim.api.nvim_set_keymap(
  'n',
  '<leader>np',
  ':lua require("slip.actions").create_note({edit_cmd = "vs"})<cr>',
  {noremap = true}
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>nb',
  ':lua require("slip.actions").create_note({edit_cmd = "vs", type = "bibliographical"})<cr>',
  {noremap = true}
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>fn',
  ':lua require("slip.actions").find_notes()<cr>',
  {noremap = true}
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>il',
  ':lua require("slip.actions").insert_link()<cr>',
  {noremap = true}
)

vim.api.nvim_set_keymap(
  'i',
  '<leader>il',
  '<cmd>lua require("slip.actions").insert_link()<cr>',
  {noremap = true}
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>nlg',
  '<cmd>lua require("slip.actions").live_grep()<cr>',
  {noremap = true}
)
