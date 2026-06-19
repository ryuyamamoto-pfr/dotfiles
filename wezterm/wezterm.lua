-- ~/.config/wezterm/wezterm.lua
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.front_end = "OpenGL"

-- ── フォント ──
-- 候補（切り替えたいときはコメントを入れ替える）:
--   "CaskaydiaMono Nerd Font" / "PlemolJP Console NF" / "JetBrains Mono Nerd Font"
config.font = wezterm.font {
  family = "UDEV Gothic NF",
  harfbuzz_features = { "liga=0", "clig=0", "calt=0" }, -- リガチャ（合字）を無効化
}
config.font_size = 12.0

-- ── 配色 ──
-- 候補: "Solarized Dark Higher Contrast" / "Solarized Dark (Gogh)"
config.color_scheme = "Afterglow"
config.bold_brightens_ansi_colors = true

config.window_background_opacity = 0.85
config.native_macos_fullscreen_mode = false
config.macos_window_background_blur = 20
-- ── ウィンドウ装飾 ──
-- 'RESIZE' のみ = タイトルバー無し・統合ボタン無し。
-- これによりタブバー左端の予約スペースが消え、tabline の NORMAL が左上に密着する。
-- （ウィンドウ操作はキーボードで: Cmd+W 閉じる / Cmd+Q 終了 / Cmd+M 最小化）
config.window_decorations = 'RESIZE'

-- ── タブバー（tabline プラグインに合わせてレトロ表示にする）──
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

-- ── 環境変数 ──
config.set_environment_variables = {
  LANG = "en_US.UTF-8",
  LC_ALL = "en_US.UTF-8",
}

-- ── キーバインド ──
config.keys = {
  { key = 'Enter', mods = 'CMD', action = wezterm.action.ToggleFullScreen },
  -- タブ切替は alt を AeroSpace(i3) に譲り ctrl+shift に
  { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
  { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
}

-- ── tabline.wez（初回起動時に git で自動取得される）──
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
