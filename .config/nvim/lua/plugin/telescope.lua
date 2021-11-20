-- Configuration of telescope plugin

local telescope_actions = require("telescope.actions.set")

-- until they fix https://github.com/nvim-telescope/telescope.nvim/issues/559
local fixfolds = {
  hidden = true,
  attach_mappings = function(_)
    telescope_actions.select:enhance({
      post = function()
        vim.cmd(":normal! zx")
      end,
    })
    return true
  end,
}

require('telescope').setup {
  pickers = {
    buffers = fixfolds,
    file_browser = fixfolds,
    find_files = fixfolds,
    git_files = fixfolds,
    grep_string = fixfolds,
    live_grep = fixfolds,
    oldfiles = fixfolds,
  },
}

require('telescope').load_extension('fzf')

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
  ':lua require("telescope.builtin").file_browser()<cr>',
  {noremap = true, silent = true}
)
