-- Configuration of telescope plugin

local keymap = require 'db.keymap'
local nmap = keymap.nmap

local fb_actions = require "telescope".extensions.file_browser.actions
local utils = require 'telescope.utils'
local builtin = require 'telescope.builtin'

require('telescope').setup {
  pickers = {
    git_files = {
      show_untracked = true,
    },
    find_files = {
      hidden = true,
      no_ignore = false,
    },
    live_grep = {
      additional_args = { "--hidden" }
    },
  },
  extensions = {
    -- TODO: Buffers mappings
    -- TODO: Is this the correct way how to do mappings?
    file_browser = {
      hidden = true,
      mappings = {
        ["n"] = {
          ["<leader>n"] = fb_actions.create,
          ["<leader>y"] = fb_actions.copy,
          ["<leader>c"] = fb_actions.rename,
          ["<leader>d"] = fb_actions.remove,
          ["-"] = fb_actions.goto_parent_dir,
        },
      },
    },
  },
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('markdown-links')

nmap({
  '<leader>fd',
  function()
    builtin.git_files({
      -- TODO: Find dotfiles automatically
      cwd = "~/docs/dotfiles",
      prompt_title = "Dotfiles",
    })
  end,
  { noremap = true, silent = true }
})

nmap({
  '<leader>ff',
  function()
    local cwd = vim.uv.cwd()
    local in_worktree = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' }, cwd)
    if in_worktree[1] ~= 'true' then
      return builtin.find_files()
    else
      return builtin.git_files({ show_untracked = true })
    end
  end,
  { noremap = true, silent = true }
})

nmap({
  '<leader>fb',
  builtin.buffers,
  { noremap = true, silent = true }
})

nmap({
  '<leader>fg',
  builtin.live_grep,
  { noremap = true, silent = true }
})

nmap({
  '<leader>ft',
  function()
    require("telescope").extensions.file_browser.file_browser({
      path = vim.fn.expand("%:p:h")
    })
  end,
  { noremap = true, silent = true }
})
nmap({
  '<leader>fp',
  function()
    builtin.find_files {
      cwd = '~/.local/share/nvim/bundle/',
    }
  end,
  { noremap = true, silent = true }
})
nmap({
  '<leader>fh',
  builtin.help_tags,
  { noremap = true, silent = true }
})
