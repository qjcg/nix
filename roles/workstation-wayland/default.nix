{ pkgs, ... }:

{
  programs.sway.enable = true;
  programs.sway.extraPackages = with pkgs; [
    xwayland
    swaybg # required by sway for controlling desktop wallpaper
    swayidle # used for controlling idle timeouts and triggers (screen locking, etc)
    swaylock # used for locking Wayland sessions

    #waybar # polybar-alike
    #i3status-rust # simpler bar written in Rust

    gebaar-libinput # libinput gestures utility
    #glpaper # GL shaders as wallpaper
    grim # screen image capture
    kanshi # dynamic display configuration helper
    mako # notification daemon
    oguri # animated background utility
    #redshift-wayland # patched to work with wayland gamma protocol
    slurp # screen area selection tool
    #waypipe # network transparency for Wayland
    wf-recorder # wayland screenrecorder
    wl-clipboard # clipboard CLI utilities
    wofi # dmenu replacement for wayland
    wtype # xdotool, but for wayland

    # TODO: more steps required to use this?
    #xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
  ];

  environment.systemPackages = with pkgs;
    [
      # other compositors/window-managers
      #waybox   # An openbox clone on Wayland
      #bspwc    # Wayland compositor based on BSPWM
      #cage # A Wayland kiosk (runs a single app fullscreen)
      #wayfire # 3D wayland compositor
      wdisplays
      #wf-config # wayfire config manager
    ];
}
