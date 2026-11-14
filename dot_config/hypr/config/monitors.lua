hl.monitor({
  output   = "DP-5",
  mode     = "3440x1440@240",
  position = "0x0",
  scale    = 1,
  bitdepth = 10,
  vrr      = 0,
})

hl.monitor({
  output   = "eDP-1",
  mode     = "3840x2400@240",
  position = "auto-right",
  scale    = 2,
  bitdepth = 10,
  vrr      = 0,
})
