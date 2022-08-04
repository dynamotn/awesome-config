-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

-- { Error handling, variable definitions, pre-setup
require('bootstrap')
require('global')
-- }

-- Initial theme
require('beautiful').init(require('theme'))

-- Bindings
require('bindings').setup()

-- On-the-fly setup
require('signals')
