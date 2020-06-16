{ secrets, ... }:

''
  # i3status-rust configuration
  # See: https://github.com/greshake/i3status-rust/blob/master/blocks.md

  theme = "plain"

  [icons]
  name = "awesome"

  [[block]]
  block = "xrandr"
  resolution = false

  [[block]]
  block = "sound"

  [[block]]
  block = "time"
  interval = 60
  format = "%a %b %-d, %-I:%M%P"
''
