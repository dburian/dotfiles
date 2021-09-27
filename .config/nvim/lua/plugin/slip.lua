config_require'slip'.setup{
  slips = {
    main = {
      name = 'Main',
      path = '/home/dburian/Documents/wiki',
    },
    slip = {
      name = 'Slip logs',
      --FIXME does not understand ~
      path = '/home/dburian/Documents/Slip.nvim/logs',
    }
  },
  default_slip = 'main',
}

vim.api.nvim_set_keymap(
  'n',
  '<leader>ns',
  ':lua require("slip.actions").create_note()<cr>',
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
