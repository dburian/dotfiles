-- Configuration of telescope plugin

local keymap = require 'db.keymap'
local nmap = keymap.nmap

local actions = require 'telescope.actions'
local actions_state = require "telescope.actions.state"
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
      mappings = {
        -- TODO: This does not work
        n = {
          ["<leader>n"] = fb_actions.create,
          ["<leader>y"] = fb_actions.copy,
          ["<leader>c"] = fb_actions.rename,
          ["<leader>d"] = fb_actions.remove,
        },
      },
    },
    live_grep = {
      additional_args = { "--hidden" }
    },
    buffers = {
      mappings = {
        n = {
          -- Performes 'save buffer deletion'
          ["<leader>d"] = function()
            local selection = actions_state.get_selected_entry()
            local prompt_bufnr = vim.api.nvim_get_current_buf()

            if vim.bo[selection.bufnr].modified then
              print("Buffer " .. selection.filename .. " has unsaved changes.")
              actions.select_default(prompt_bufnr)
            else
              actions.delete_buffer(prompt_bufnr)
              actions_state.get_current_picker(prompt_bufnr):set_prompt("")
            end
          end
        },

      },
    },
  },
  extensions = {
    file_browser = {
      hidden = true,
      mappings = {
        n = {
          -- Disabling default keybindings
          c = false,
          g = false,
          r = false,
          d = false,
          y = false,

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
      cwd = "~/Documents/dotfiles",
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
