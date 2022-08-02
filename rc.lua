-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

-- { Error handling, variable definitions, pre-setup
require('global')
-- }

-- { Bindings
require('bindings').setup()
-- }

-- { Screen setup
-- Panel
require('panel')
-- }

-- { On-the-fly setup
-- Rules
require('rules')
-- Signals
require('signals')
-- }
