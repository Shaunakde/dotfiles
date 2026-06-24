-- Import the wezterm module
local wezterm = require 'wezterm'

-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()

-- Slightly transparent and blurred background
config.window_background_opacity = 0.9
config.macos_window_background_blur = 30
-- Removes the title bar, leaving only the tab bar. Keeps
-- the ability to resize by dragging the window's edges.
-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
-- you want to keep the window controls visible and integrate
-- them into the tab bar.
config.window_decorations = 'RESIZE|INTEGRATED_BUTTONS'
-- Sets the font for the window frame (tab bar)
-- config.window_frame = {
  -- Berkeley Mono for me again, though an idea could be to try a
  -- serif font here instead of monospace for a nicer look?
  --font = wezterm.font({ family = 'Berkeley Mono', weight = 'Bold' }),
  -- font_size = 12,
-- }


-- Bottom tab bar with resizing to fill out the width of the window
-- Adapted from blog post: https://blog.dm4.tw/wezterm-tab-width-fill-tab-bar-eng
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 999

function get_max_cols(window)
  local tab = window:active_tab()
  local cols = tab:get_size().cols
  return cols
end

wezterm.on(
  'window-config-reloaded',
  function(window)
    wezterm.GLOBAL.cols = get_max_cols(window)
  end
)

wezterm.on(
  'window-resized',
  function(window, pane)
    wezterm.GLOBAL.cols = get_max_cols(window)
  end
)

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab.active_pane.title
    local full_title = '[' .. tab.tab_index + 1 .. '] ' .. title
    local pad_length = (wezterm.GLOBAL.cols // #tabs - #full_title) // 2
    if pad_length * 2 + #full_title > max_width then
      pad_length = (max_width - #full_title) // 2
    end
    return string.rep(' ', pad_length) .. full_title .. string.rep(' ', pad_length)
  end
)

-- Returns our config to be evaluated. We must always do this at the bottom of this file
return config

