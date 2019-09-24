-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- { Error handling, variable definitions, pre-setup
require("global")
-- }

-- { Third party application
-- Autostart application at startup
require("autostart")
-- }

-- { Bindings
-- Mouse
require("mouse_bindings")
-- Keyboard
require("key_bindings")
-- }

-- { Screen setup
-- Menu
require("menu")
-- Panel
require("panel")
-- Monitor
require("monitor")
-- }

-- { On-the-fly setup
-- Rules
require("rules")
-- Signals
require("signals")
-- }
