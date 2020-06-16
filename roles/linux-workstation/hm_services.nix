{ pkgs, ... }:

{
  services = {

    dunst = {
      enable = true;

      # Docs: https://github.com/dunst-project/dunst/blob/master/docs/dunst.pod
      settings = {

        global = {
          monitor = "1";
          alignment = "center";
          geometry = "600x600+25+50";
          browser = "${pkgs.firefox}/bin/firefox -new-tab";
          dmenu =
            "${pkgs.dmenu}/bin/dmenu -fn 'Victor Mono:size=14' -nb '#000000' -sb '#a10094' -sf '#ffffff'";
          font = "Victor Mono Medium 15";
          frame_width = "2";
          padding = "20";
          corner_radius = "10";

          # Docs: https://developer.gnome.org/pango/stable/pango-Markup.html
          markup = "full";
          format = "<span foreground='#38dbff'><b><i>%a</i></b></span>  %s %b";
        };

        shortcuts = {
          close = "ctrl+space";
          close_all = "ctrl+shift+space";
          history = "ctrl+apostrophe";
          context = "ctrl+shift+apostrophe";
        };

        urgency_low = {
          background = "#000000";
          foreground = "#999999";
          frame_color = "#76ff3a";
          separator_color = "#a2ffa2";
        };

        urgency_normal = {
          background = "#000000";
          foreground = "#ffffff";
          frame_color = "#76ff3a";
          separator_color = "#a2ffa2";
        };

        urgency_critical = {
          background = "#000000";
          foreground = "#ff3838";
          frame_color = "#76ff3a";
          separator_color = "#a2ffa2";
        };

      };
    };

    gpg-agent = {
      enable = true;
      defaultCacheTtl = 3600;
      defaultCacheTtlSsh = 3600;
      enableScDaemon = false;
      enableSshSupport = true;
      extraConfig = ''
        allow-emacs-pinentry
        pinentry-program /usr/bin/pinentry-gnome3
      '';
    };

    # FIXME: i3lock does NOT unlock with correct password!
    #services.screen-locker = {
    #  enable = true;
    #  lockCmd = "${pkgs.i3lock}/bin/i3lock -n -c 000000";
    #};

    # TODO: Determine whether systemctlPath is needed for anything (Ubuntu 18.04).
    #systemd.user = {
    #  systemctlPath = "/usr/bin/systemctl";
    #};

  };

}
