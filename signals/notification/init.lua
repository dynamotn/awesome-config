-- AwesomeWM standard library
local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local ruled = require('ruled')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local wibox = require('wibox')
-- Notification library
local naughty = require('naughty')
-- Rules
local rules = require('rules')

naughty.connect_signal('request::display', function(n)
  naughty.layout.box({
    notification = n,
    type = 'notification',
    screen = awful.screen.preferred(),
    shape = gears.shape.rounded_rect,
    border_width = 0,
    border_color = beautiful.transparent,
    widget_template = {
      {
        {
          {
            {
              {
                {
                  {
                    {
                      {
                        {
                          resize_strategy = 'center',
                          widget = naughty.widget.icon,
                        },
                        margins = beautiful.notification_margin,
                        widget = wibox.container.margin,
                      },
                      {
                        {
                          layout = wibox.layout.align.vertical,
                          expand = 'none',
                          nil,
                          {
                            {
                              align = 'left',
                              widget = naughty.widget.title,
                            },
                            {
                              align = 'left',
                              widget = naughty.widget.message,
                            },
                            layout = wibox.layout.fixed.vertical,
                          },
                          nil,
                        },
                        margins = beautiful.notification_margin,
                        widget = wibox.container.margin,
                      },
                      layout = wibox.layout.fixed.horizontal,
                    },
                    fill_space = true,
                    spacing = beautiful.notification_margin,
                    layout = wibox.layout.fixed.vertical,
                  },
                  -- Margin between the fake background
                  -- Set to 0 to preserve the 'titlebar' effect
                  margins = dpi(0),
                  widget = wibox.container.margin,
                },
                bg = beautiful.transparent,
                widget = wibox.container.background,
              },
              spacing = dpi(4),
              layout = wibox.layout.fixed.vertical,
            },
            bg = beautiful.transparent,
            id = 'background_role',
            widget = naughty.container.background,
          },
          strategy = 'min',
          width = dpi(160),
          widget = wibox.container.constraint,
        },
        strategy = 'max',
        width = beautiful.notification_max_width or dpi(500),
        widget = wibox.container.constraint,
      },
      bg = beautiful.notification_bg,
      shape = gears.shape.rounded_rect,
      widget = wibox.container.background,
    },
  })
end)

ruled.notification.connect_signal('request::rules', function()
  ruled.notification.append_rule(rules.notification)
end)
