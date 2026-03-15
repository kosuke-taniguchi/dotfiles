-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
--config.color_scheme = 'OneDark (base16)'
config.color_scheme = "Dracula+"

-- scroll backline
config.scrollback_lines = 50000

-- ime
config.use_ime = true

config.window_background_opacity = 0.85

allow_square_glyphs_to_overflow_width = false

-- ショートカットキー設定
local act = wezterm.action
config.keys = {
  -- Alt(Opt)+Shift+Fでフルスクリーン切り替え
  {
    key = 'f',
    mods = 'SHIFT|META',
    action = wezterm.action.ToggleFullScreen,
  },
  -- Ctrl+Shift+tで新しいタブを作成
  {
    key = 't',
    mods = 'SHIFT|CTRL',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  -- Ctrl+Shift+rで新しいペインを右に作成
  {
    key = 'r',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  -- Ctrl+Shift+dで新しいペインを下に作成
  {
    key = 'd',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    },
  },
  -- Ctrl+Shift+cでペインをクローズ
  {
    key = 'c',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
}

-- フォントサイズの設定
config.font_size = 12

-- and finally, return the configuration to wezterm
return config
