--[[
                                 
     Licensed under MIT License  
      * (c) 2013, Luke Bonham    
      * (c) 2009, Uli Schlachter 
      * (c) 2009, Majic          
                                 
--]]

local beautiful    = require("beautiful")
local tostring     = tostring
local setmetatable = setmetatable

local html = {}

local fg = {}
local bg = {}

-- Convenience tags.
function html.bold(text)      return '<b>'     .. tostring(text) .. '</b>'     end
function html.italic(text)    return '<i>'     .. tostring(text) .. '</i>'     end
function html.strike(text)    return '<s>'     .. tostring(text) .. '</s>'     end
function html.underline(text) return '<u>'     .. tostring(text) .. '</u>'     end
function html.monospace(text) return '<tt>'    .. tostring(text) .. '</tt>'    end
function html.big(text)       return '<big>'   .. tostring(text) .. '</big>'   end
function html.small(text)     return '<small>' .. tostring(text) .. '</small>' end

-- Set the font.
function html.font(font, text)
  return '<span font="'  .. tostring(font)  .. '">' .. tostring(text) ..'</span>'
end

-- Set the foreground.
function fg.color(color, text)
  return '<span foreground="' .. tostring(color) .. '" font="' .. tostring(beautiful.font) ..'">' .. tostring(text) .. '</span>'
end

-- Set the background.
function bg.color(color, text)
  return '<span background="' .. tostring(color) .. '" font="' .. tostring(beautiful.font_background) ..'">' .. tostring(text) .. '</span>'
end

-- Context: focus
function fg.focus(text) return fg.color(beautiful.fg_focus, text) end
function bg.focus(text) return bg.color(beautiful.bg_focus, text) end
function html.focus(text) return bg.focus(fg.focus(text)) end

-- Context: normal
function fg.normal(text) return fg.color(beautiful.fg_normal, text) end
function bg.normal(text) return bg.color(beautiful.bg_normal, text) end
function html.normal(text) return bg.normal(fg.normal(text)) end

-- Context: urgent
function fg.urgent(text) return fg.color(beautiful.fg_urgent, text) end
function bg.urgent(text) return bg.color(beautiful.bg_urgent, text) end
function html.urgent(text) return bg.urgent(fg.urgent(text)) end

html.fg = fg
html.bg = bg

-- link html.{fg,bg}(...) calls to html.{fg,bg}.color(...)
setmetatable(html.fg, { __call = function(_, ...) return html.fg.color(...) end })
setmetatable(html.bg, { __call = function(_, ...) return html.bg.color(...) end })

-- link html(...) calls to html.fg.color(...)
return setmetatable(html, { __call = function(_, ...) return html.fg.color(...) end })
