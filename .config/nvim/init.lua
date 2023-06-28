-- My neovim configuration
--
--  - lua/db - lua files that export util functions
--  - after/plugin - configuration of plugins (possibly using lua/db/..)
--  - plugin/ - files that should be loaded automatically ASAP


-- Load plugins
require('db.plugins')

-- Globals
require('db.globals')
