
require('slip').setup({
  slips = {
    main = {
      path = '/home/dburian/Documents/wiki',
    },
    slip = {
      --FIXME for some reason does not understand ~
      path = '/home/dburian/Documents/Slip.nvim/logs',
    }
  }
})

vim.api.nvim_set_keymap(
  'n',
  '<leader>ns',
  ':lua require("slip").new_note()<cr>',
  {noremap = true}
)
