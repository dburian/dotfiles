local scandir = require('plenary.scandir')
local Path = require('plenary.path')

local c = {
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

-- TODO: separate file exporting source
-- Helper functions
local function curr_slip()
  local dirpath = vim.loop.fs_realpath(vim.fn.expand'%:p:h')

  for slip_name, slip in pairs(c.slips) do
    if vim.startswith(dirpath, slip.path) then
      return slip_name
    end
  end

  return nil
end

local function get_notes(slip_name)
  local slip_path = c.slips[slip_name].path
  local paths = scandir.scan_dir(slip_path, {
    add_dirs = false,
    hidden = false,
    depth = 5, --TODO: in config later
    search_pattern = '.*%.md',
  })

  local notes = {}
  for _, path in ipairs(paths) do
    local rel_path = Path.new(path):make_relative(slip_path)
    table.insert(notes, {
      path = path,
      rel_path = rel_path,
      id = vim.fn.fnamemodify(Path.new(rel_path):shorten(), ':r'),
      contents = Path.new(path):read()
    })
  end

  return notes
end

local function get_buf_links(buffer)
  local buf_lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
  local lines = {}
  for _, line in ipairs(buf_lines) do
    local note_id, note_rel_path = string.match(line, '%[([^]]*)%]:%s*(.*%.md)$')
    if note_id and note_rel_path then
      lines[note_rel_path] = note_id
    end
  end

  return lines
end

-- nvim-cmp source
local link_cmp_source = {}

function link_cmp_source.new()
  local self = setmetatable({}, {__index = link_cmp_source})

  return self
end

function link_cmp_source:get_debug_name()
  return 'Slip link completion'
end

function link_cmp_source:is_available()
  return (
    vim.opt.filetype:get() == 'markdown' and
    curr_slip() ~= nil
  )
end

function link_cmp_source.get_trigger_characters()
  return {'['}
end

function link_cmp_source:complete(params, callback)

  -- TODO: Configure if in text or separate
  -- Only display entries for link targets
  if not vim.endswith(params.context.cursor_before_line, '][') then
    return callback()
  end

  local slip_name = curr_slip()

  if not slip_name then
    return callback(nil)
  end

  local line_count = vim.api.nvim_buf_line_count(0)
  local linked_notes = get_buf_links(0)

  P(linked_notes)

  local notes = get_notes(slip_name)

  local entries = {}
  for _, note in ipairs(notes) do
    local link_ref = '[' .. note.id .. ']: ' .. note.rel_path

    note.id = linked_notes[note.rel_path] or note.id

    local entry = {
      label = note.rel_path,
      documentation = {
        kind = 'markdown',
        value = note.contents
      },
      detail = slip_name,
      insertText = note.id .. ']'
    }

    if not linked_notes[note.rel_path] then
      entry.additionalTextEdits = {
        {
          newText = link_ref,
          --TODO: Configure begining of buffer or at end
          range = {
            start = {
              line = line_count,
              character = 0,
            },
            ['end'] = {
              line = line_count,
              character = string.len(link_ref)
            }
          }
        },
      }
    end

    table.insert(entries, entry)
  end

  callback(entries)
end

local src_id = nil

if src_id then
  require'cmp'.unregister_source(src_id)
end

src_id = require'cmp'.register_source('slip', link_cmp_source.new())

local slip_au_group_id = vim.api.nvim_create_augroup('slip', {})
vim.api.nvim_create_autocmd({'BufEnter'}, {
  group = slip_au_group_id,
  pattern = '*.md',
  callback = function ()
    require'cmp'.setup.buffer{ sources = {{name = 'slip'}} }
  end,
})



-- vim.api.nvim_set_keymap(
--   'n',
--   '<leader>np',
--   ':lua require("slip.actions").create_note({edit_cmd = "vs"})<cr>',
--   {noremap = true}
-- )

-- vim.api.nvim_set_keymap(
--   'n',
--   '<leader>nb',
--   ':lua require("slip.actions").create_note({edit_cmd = "vs", type = "bibliographical"})<cr>',
--   {noremap = true}
-- )

-- vim.api.nvim_set_keymap(
--   'n',
--   '<leader>fn',
--   ':lua require("slip.actions").find_notes()<cr>',
--   {noremap = true}
-- )

-- vim.api.nvim_set_keymap(
--   'n',
--   '<leader>il',
--   ':lua require("slip.actions").insert_link()<cr>',
--   {noremap = true}
-- )

-- vim.api.nvim_set_keymap(
--   'i',
--   '<leader>il',
--   '<cmd>lua require("slip.actions").insert_link()<cr>',
--   {noremap = true}
-- )

-- vim.api.nvim_set_keymap(
--   'n',
--   '<leader>nlg',
--   '<cmd>lua require("slip.actions").live_grep()<cr>',
--   {noremap = true}
-- )
