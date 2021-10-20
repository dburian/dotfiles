-- Configuration of telescope plugin

local action_set = require('telescope.actions.set')

-- until they fix https://github.com/nvim-telescope/telescope.nvim/issues/559
require('telescope').setup {
  pickers = {
    find_files = {
      hidden = true,
      attach_mappings = function()
        action_set.select:enhance({
          post = function()
            vim.cmd(":normal! zx")
          end
        })
        return true
      end
    },
    git_files = {
      hidden = true,
      attach_mappings = function()
        action_set.select:enhance({
          post = function()
            vim.cmd(":normal! zx")
          end
        })
        return true
      end
    },
    live_grep = {
      hidden = true,
      attach_mappings = function()
        action_set.select:enhance({
          post = function()
            vim.cmd(":normal! zx")
          end
        })
        return true
      end
    },
  }
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
