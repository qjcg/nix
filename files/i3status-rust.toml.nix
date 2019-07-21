{ secrets, ... }:

''
# i3status-rust configuration
# See: https://github.com/greshake/i3status-rust/blob/master/blocks.md

theme = "slick"

[icons]
name = "awesome"

# TODO: Fix broken icons
# Ref: https://github.com/greshake/i3status-rust/wiki/Theming-&-Icons#overwriting-themes-and-icon-sets
[icons.overrides]
#time = ""
#volume_full = ""

# DISABLED: "response contained malformed JSON" error causing bar to error out.
#[[block]]
#block = "weather"
#format = "{temp}°/{weather}"
#service = { name = "openweathermap", api_key = "${secrets.openweathermap-api-key}", city_id = "${secrets.openweathermap-city-id}", units = "metric" }

# DISABLED: Information overload.
#[[block]]
#block = "nvidia_gpu"
#label = "Quadro P1000"

# DISABLED: Information overload.
#[[block]]
#block = "xrandr"
#resolution = true

# DISABLED: Information overload.
#[[block]]
#block = "uptime"

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
