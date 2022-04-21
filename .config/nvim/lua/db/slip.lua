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

function link_cmp_source:get_keyword_pattern()
  return [=[\v\[[^\]]+\]\[]=]
end

function link_cmp_source:get_trigger_characters()
  return {'['}
end

function link_cmp_source:complete(_, callback)
  callback({
    {label = 'ahoj'},
  })
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
