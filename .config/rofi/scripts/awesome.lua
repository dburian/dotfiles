#!/home/dburian/.local/bin/awesome-lua

-- Enumerates all unempty workspaces and number of windows associated with each
-- one

local awful = require('awful')
local gears = require('gears')

local tag_num_clients = {}

local record_client = function(c)
  local t = tag_num_clients
  for _, tag in ipairs(c:tags()) do
    if t[tag] == nil then
      t[tag] = 1
    else
      t[tag] = 1 + t[tag]
    end
  end
end

local record_screen = function(s)
  for _, client in ipairs(s.all_clients) do
    record_client(client)
  end
end

for s in screen do
  record_screen(s)
end

for tag, num_of_clients in pairs(tag_num_clients) do
  print('%s: %s', tag, num_of_clients)
end

return gears.debug.dump_return(tag_num_clients)

