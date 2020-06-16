{ secrets, ... }:

''
  # i3status-rust configuration
  # See: https://github.com/greshake/i3status-rust/blob/master/blocks.md

  theme = "plain"

  [icons]
  name = "awesome"

  [[block]]
  block = "custom"
  command = "echo LOCK"
  on_click = "swaylock"
  interval = 3600

  [[block]]
  block = "battery"
  format = "{percentage}% {time}"

  [[block]]
  block = "disk_space"
  path = "/"
  alias = "/"
  info_type = "available"
  unit = "GB"
  interval = 20
  warning = 20.0
  alert = 10.0

  [[block]]
  block = "load"
  interval = 1
  format = "{1m} {5m} {15m}"

  [[block]]
  block = "sound"

  [[block]]
  block = "time"
  interval = 60
  format = "%a %b %-d, %-I:%M%P"
''
