-- Anythink I would like to have at hand anytime in nvim
--

function unload_module(module_name)
  local matcher = function (loaded_module)
    return string.find(loaded_module, module_name, 1, true)
  end

  for loaded_m, _ in pairs(package.loaded) do
    if matcher(loaded_m) then
      package.loaded[loaded_m] = nil
    end
  end
end

function reload_module(module_name)
  unload_module(module_name)
  return require(module_name)
end

local config_modules = {}

function config_require(modulename)
  local m = require(modulename)
  table.insert(config_modules, modulename)

  return m
end

function reload_config()
  for _, m in ipairs(config_modules) do
    unload_module(m)
  end

  vim.cmd('luafile ~/.config/nvim/init.lua')
end
