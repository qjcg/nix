# i3-compatible wayland compositor.
{ config, pkgs, ... }:

{
  config = {

    programs.sway = {
      enable = true;
      extraPackages = with pkgs; [
        xwayland
        swaybg # required by sway for controlling desktop wallpaper
        swayidle # used for controlling idle timeouts and triggers (screen locking, etc)
        swaylock # used for locking Wayland sessions
        waybar # polybar-alike

        #cage # A Wayland kiosk (runs a single app fullscreen)
        gebaar-libinput # libinput gestures utility
        glpaper # GL shaders as wallpaper
        grim # screen image capture
        kanshi # dynamic display configuration helper
        mako # notification daemon
        oguri # animated background utility
        slurp # screen area selection tool
        wayfire # 3D wayland compositor
        waypipe # network transparency for Wayland
        #wdisplays
        wev # A tool for debugging events on a Wayland window, analagous to the X11 tool xev.
        wf-recorder # wayland screenrecorder
        wl-clipboard # clipboard CLI utilities
        wldash # wayland launcher/dashboard

        wlogout # wayland-based logout menu
        wofi # dmenu replacement for wayland
        wtype # xdotool, but for wayland

        # FIXME not building 2021-04-17
        #i3status-rust # simpler bar written in Rust

        # TODO: more steps required to use this?
        #xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
      ];
    };

  };
}
