local pickers = require 'telescope.pickers'
local previewers = require "telescope.previewers"
local action_set = require "telescope.actions.set"
local action_state = require "telescope.actions.state"
local flatten = vim.tbl_flatten
local finders = require 'telescope.finders'
local conf = require 'telescope.config'.values
local nmap = require 'db.keymap'.nmap
local make_entry = require "telescope.make_entry"
local entry_display = require 'telescope.pickers.entry_display'

-- TODO: Wrap this into a plugin (telescope extension)

local kind_highlight = setmetatable({
  c = "TelescopeResultsClass",
  m = "TelescopeResultsField",
  f = "TelescopeResultsFunction",
  v = "TelescopeResultsVariable",
}, {
  __index = function()
    return "TelescopeResultsIdentifier"
  end
})

local kind_name = setmetatable({
  f = "function",
  m = "member",
  c = "class",
  i = "module",
  v = "variable",
}, {
  __index = function()
    return "unknown"
  end
})

local function get_tags_entry_maker(opts)
  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = 25 },
      { width = 15 },
      {}
    }
  }

  local make_display = opts.make_display or function(entry)
    return displayer {
      entry.value.name,
      { '[' .. kind_name[entry.value.kind] .. ']', kind_highlight[entry.value.kind] },
      entry.filename,
      -- {'[' .. entry.value.label .. ']', "TelescopeResultsComment" },
    }
  end

  return function(entry)
    return {
      value = entry,
      display = make_display,
      ordinal = table.concat({
        entry.name,
        entry.filename,
      }, ':'),
      filename = entry.filename
    }
  end
end

local jump_to_tag = function(tagname)
end

local telescope_tag_select = function(opts)
  opts = opts or {}

  local tagname = opts.tagname or vim.fn.expand("<cword>")

  local matching_tags = vim.fn.taglist("^" .. tagname .. "$")
  if #matching_tags == 0 then
    vim.notify("No tags match '" .. tagname .. "'.", vim.log.levels.INFO)
    return
  elseif #matching_tags == 1 then
    local tag = matching_tags[1]
    vim.cmd('edit ' .. tag.filename)
    vim.fn.search(tag.cmd)
    vim.cmd [[normal zz]]
    return
  end

  pickers.new(opts, {
    prompt_title = "Definitions for '" .. tagname .. "'",
    finder = finders.new_table {
      results = matching_tags,
      entry_maker = get_tags_entry_maker(opts),
    },
    sorter = conf.generic_sorter(opts),
    -- TODO: previewer
    -- TODO: select:enhance...
  }):find()
end

local telescope_tag_select_rg = function(opts)
  opts = opts or {}
  opts.bufnr = 0

  if vim.fn.executable("rg") == 0 then
    vim.notify("You need to install rg.", vim.log.levels.ERROR)
    return
  end

  local tagname = opts.tagname or (opts.search_cword and vim.fn.expand("<cword>")) or nil

  local tags_command = { "rg", "-H", "-N", "--no-heading", "--color", "never" }
  if tagname == nil then
    -- find lines not matching tags file format (begins with !) or empty lines.
    table.insert(tags_command, "-v")
    table.insert(tags_command, "^!|^$")
  else
    -- find lines matching our tagname
    table.insert(tags_command, "-e")
    table.insert(tags_command, "^" .. tagname .. '\t')
  end

  local tagfiles = opts.ctags_file and { opts.ctags_file } or vim.fn.tagfiles()
  for i, ctags_file in ipairs(tagfiles) do
    tagfiles[i] = vim.fn.expand(ctags_file, true)
  end
  if vim.tbl_isempty(tagfiles) then
    vim.notify("No tags file found. Create one with ctags -R", vim.log.levels.ERROR)
    return
  end

  opts.entry_maker = vim.F.if_nil(opts.entry_maker, make_entry.gen_from_ctags(opts))

  -- TODO: Ideally we would know we have one/zero matches before we run telescope UI
  pickers
      .new(opts, {
        prompt_title = tagname and "Tags matching '" .. tagname .. "'" or "Tags",
        finder = finders.new_oneshot_job(flatten { tags_command, tagfiles }, opts),
        previewer = previewers.ctags.new(opts),
        sorter = conf.generic_sorter(opts),
        on_complete = { function(picker)
          -- remove this on_complete callback
          picker:clear_completion_callbacks()
          -- if we have exactly one match, select it
          local num_of_entries = picker.manager.linked_states.size
          if num_of_entries == 1 then
            require("telescope.actions").select_default(picker.prompt_bufnr)
          elseif num_of_entries == 0 then
            require "telescope.actions".close(picker.prompt_bufnr)
            if tagname == nil then
              vim.notify("No tags found.", vim.log.levels.INFO)
            else
              vim.notify("No tags matching '" .. tagname "' found.", vim.log.levels.INFO)
            end
          end
        end,
        },
        attach_mappings = function()
          action_set.select:enhance {
            post = function()
              local selection = action_state.get_selected_entry()
              if not selection then
                return
              end

              if selection.scode then
                -- un-escape / then escape required
                -- special chars for vim.fn.search()
                -- ] ~ *
                local scode = selection.scode:gsub([[\/]], "/"):gsub("[%]~*]", function(x)
                  return "\\" .. x
                end)

                vim.cmd "keepj norm! gg"
                vim.fn.search(scode)
                vim.cmd "norm! zz"
              else
                vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
              end
            end,
          }
          return true
        end,
      })
      :find()
end

-- nmap({ '<leader>gd', telescope_tag_select, { noremap = true } })
-- nmap({ '<leader>fv', function() telescope_tag_select_rg({ search_cword = true, fname_width = 40 }) end,
--   { noremap = true } })

local M = {
  telescope_tag_select = telescope_tag_select_rg,
}

return M
