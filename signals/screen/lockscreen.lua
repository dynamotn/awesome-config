-- AwesomeWM standard library
local awful = require('awful')
local gears = require('gears')
-- Widget and layout library
local wibox = require('wibox')
-- Theme handling library
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
-- Custom library
local str = require('lib.string')
local session = require('lib.session')

screen.connect_signal('request::desktop_decoration', function(s)
  -- Create lockscreen
  s.lockscreen = awful.wibar({
    screen = s,
    visible = false,
    ontop = true,
    type = 'splash',
    width = s.geometry.width,
    height = s.geometry.height,
  })

  s.input_password_box = wibox.widget({
    widget = wibox.widget.textbox,
    markup = '',
    font = beautiful.lockscreen_password_font,
    align = 'center',
  })
  s.warning_text = wibox.widget({
    widget = wibox.widget.textbox,
    markup = '',
    font = beautiful.font,
    align = 'center',
  })

  local password_box = wibox.widget({
    {
      {
        {
          s.input_password_box,
          margins = { left = dpi(10) },
          widget = wibox.container.margin,
        },
        nil,
        {
          wibox.widget({
            widget = wibox.widget.textbox,
            markup = ' ',
            font = beautiful.lockscreen_password_font,
            align = 'center',
            valign = 'center',
          }),
          margins = { right = dpi(10) },
          widget = wibox.container.margin,
        },
        layout = wibox.layout.align.horizontal,
        expand = 'none',
      },
      widget = wibox.container.margin,
      margins = dpi(10),
    },
    widget = wibox.container.background,
    bg = beautiful.bg_focus,
    forced_width = dpi(400),
    forced_height = dpi(40),
    shape = gears.shape.rounded_bar,
  })

  local clock = wibox.widget({
    wibox.widget({
      forced_height = dpi(240),
      layout = wibox.layout.fixed.vertical,
    }),
    {
      font = beautiful.lockscreen_time_font,
      format = str.markup_text('%I:%M:%S', beautiful.fg_normal),
      widget = wibox.widget.textclock,
      align = 'center',
      valign = 'center',
      refresh = 1,
    },
    {
      font = beautiful.lockscreen_date_font,
      format = str.markup_text('%A, %d %B %Y', beautiful.fg_normal),
      widget = wibox.widget.textclock,
      align = 'center',
      valign = 'center',
    },
    layout = wibox.layout.ratio.vertical,
  })

  local avatar = wibox.widget({
    {
      image = os.getenv('HOME') .. '/.face',
      upscale = true,
      forced_width = dpi(160),
      forced_height = dpi(160),
      clip_shape = gears.shape.circle,
      widget = wibox.widget.imagebox,
      halign = 'center',
    },
    widget = wibox.container.background,
    border_width = dpi(2),
    shape = gears.shape.circle,
    border_color = beautiful.fg_color,
  })

  local username = wibox.widget({
    widget = wibox.widget.textbox,
    markup = str.markup_text(os.getenv('USER'):gsub('^%l', string.upper), beautiful.fg_warning),
    font = beautiful.lockscreen_username_font,
    align = 'center',
    valign = 'center',
  })

  local myself = wibox.widget({
    avatar,
    username,
    spacing = dpi(15),
    layout = wibox.layout.fixed.vertical,
  })

  s.lockscreen:setup({
    {
      clock,
      {
        myself,
        {
          {
            password_box,
            s.warning_text,
            spacing = dpi(10),
            layout = wibox.layout.fixed.vertical,
          },
          layout = wibox.container.place,
        },
        layout = wibox.layout.fixed.vertical,
        spacing = dpi(50),
      },
      layout = wibox.layout.align.vertical,
      expand = 'none',
    },
    layout = wibox.layout.stack,
  })
end)

awesome.connect_signal('lockscreen::start', session.lock)
