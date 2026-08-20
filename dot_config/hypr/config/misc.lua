hl.config({
    general = {
        layout = "master",
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
        disable_hyprland_logo = true,
        font_family = "Fira Sans",
        swallow_regex = "(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)",
        vrr = 3,
    },
    render = {
        direct_scanout = 2,
    },
    xwayland = {
        force_zero_scaling = true
    },
})
