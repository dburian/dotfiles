local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require 'telescope.config'.values
local nmap = require 'db.keymap'.nmap
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

  P(tagname)
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

nmap({ '<leader>gd', telescope_tag_select, { noremap = true } })
