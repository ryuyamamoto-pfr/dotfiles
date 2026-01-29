local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.automatically_reload_config = true

-- config.font = wezterm.font("CaskaydiaMono Nerd Font")
-- config.font = wezterm.font("PlemolJP Console NF")
-- config.font = wezterm.font("JetBrains Mono")
config.font = wezterm.font {
  family = "JetBrains Mono Nerd Font",
  harfbuzz_features = { "liga=0", "clig=0", "calt=0" },
}
config.font_size = 11.0

-- config.color_scheme = "Solarized Dark Higher Contrast"
-- config.color_scheme = "Solarized Dark (Gogh)"
config.color_scheme = "Afterglow"

config.keys = {
  { key = "h", mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
  { key = "l", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
}

config.bold_brightens_ansi_colors = true

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.colors = {
  tab_bar = {
    background = "none",
  },
}
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

config.set_environment_variables = {
  LANG = "en_US.UTF-8",
  LC_ALL = "en_US.UTF-8",
}

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

tabline.setup({
  options = {
    icons_enabled = true,
    theme = 'Catppuccin Mocha',
    tabs_enabled = true,
    theme_overrides = {},
    section_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
    component_separators = {
      left = wezterm.nerdfonts.pl_left_soft_divider,
      right = wezterm.nerdfonts.pl_right_soft_divider,
    },
    tab_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
  },
  sections = {
    tabline_a = { 'mode' },
    tabline_b = { 'workspace' },
    tabline_c = { ' ' },
    tab_active = {
      'index',
      { 'parent', padding = 0 },
      '/',
      { 'cwd', padding = { left = 0, right = 1 } },
      { 'zoomed', padding = 0 },
    },
    tab_inactive = { 'index', { 'process', padding = { left = 0, right = 1 } } },
    tabline_x = { 'ram', 'cpu' },
    tabline_y = { 'datetime', 'hostname' },
    tabline_z = { 'domain' },
  },
  extensions = {},
})

return config

