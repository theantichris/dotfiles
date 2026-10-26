hl.config({
  general = {
    layout = "master",
  },
  layout = {
    single_window_aspect_ratio = { 0, 0 },
  },
  dwindle = {
    preserve_split = true,
  },
  master = {
    new_status = "slave",
    new_on_top = true,
    mfact = 0.5,
    special_scale_factor = 0.8,
    orientation = "left",
  },
  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },
  misc = {
    col = {
      splash = CACHYLGREEN,
    },
    middle_click_paste = false,
    enable_swallow = true,
    swallow_regex = "(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)",
    vrr = 3,
  },
  render = {
    -- Keep fullscreen rendering composited to avoid external-display artifacts.
    direct_scanout = 0,
    -- Enable HDR automatically for fullscreen HDR apps/games.
    -- Keep the normal desktop in SDR rather than forcing HDR always on.
    cm_auto_hdr = 1,
  },
  xwayland = {
    force_zero_scaling = true
  },
})
