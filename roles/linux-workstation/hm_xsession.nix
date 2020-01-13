{pkgs, ...}:

{
  xsession = {
    enable = true;

    pointerCursor = with pkgs; {
      name = "Vanilla-DMZ";
      package = vanilla-dmz;
      size = 64;
    };

    windowManager.i3 = 
    let
      modifier = "Mod4";

      cmd_term = "${pkgs.st}/bin/st -f 'monospace-11'";
      cmd_term_tmux = "${cmd_term} -t 'tmux-main' -e sh -c 'tmux new -ADs main'";

      cmd_menu = "${pkgs.dmenu}/bin/dmenu_run -fn 'Iosevka:size=20' -nb '#000000' -sb '#00fcff' -sf '#000000'";
      cmd_browser = "${pkgs.firefox}/bin/firefox";
      cmd_slack = "${pkgs.slack}/bin/slack";

      wpdir = "/home/jgosset/Sync/Pictures/Wallpapers" ;
      cmd_browse_wallpaper = "${pkgs.sxiv}/bin/sxiv -artos f ${wpdir}";
      cmd_set_wallpaper = "${pkgs.feh}/bin/feh --bg-fill ${wpdir}/gtgraphics.de/infinitus.jpg ${wpdir}/wallpaperfx.com/white-tiger-in-jungle-2560x1440-wallpaper-2916.jpg --geometry -550";

      left = "h";
      down = "j";
      up = "k";
      right = "l";
    in {
      enable = true;

      extraConfig = ''
        default_border  pixel 8
        title_align     center
      '';

      config = {
        fonts = [
          "Iosevka Medium 13"
        ];

        modifier = "${modifier}";

        gaps = {
          inner = 50;
          outer = 10;
        };

        keybindings =
          lib.mkOptionDefault {

            # Start apps
            "${modifier}+Return" = "exec ${cmd_term}";
            "${modifier}+d"      = "exec ${cmd_menu}";
            "${modifier}+Shift+b" = "exec ${cmd_browse_wallpaper}";

            # Focus windows
            "${modifier}+${left}"  = "focus left";
            "${modifier}+${down}"  = "focus down";
            "${modifier}+${up}"    = "focus up";
            "${modifier}+${right}" = "focus right";

            # Move windows
            "${modifier}+Shift+${left}"  = "move left";
            "${modifier}+Shift+${down}"  = "move down";
            "${modifier}+Shift+${up}"    = "move up";
            "${modifier}+Shift+${right}" = "move right";

            # Switch workspaces
            "${modifier}+n"       = "workspace next_on_output";
            "${modifier}+p"       = "workspace prev_on_output";
            "${modifier}+Tab"     = "workspace back_and_forth";

            # Move containers accross outputs.
            "${modifier}+Shift+period"       = "move container to output right";
            "${modifier}+Shift+comma"        = "move container to output left";

            # Use scratchpad
            "${modifier}+minus"       = "scratchpad show";
            "${modifier}+Shift+minus" = "move scratchpad";

            "${modifier}+Shift+e" = "exit";
            "${modifier}+Shift+x" = "kill";

            # Control cmus(1) music playback.
            "XF86AudioPlay" = "exec cmus-remote --pause";
            "XF86AudioPrev" = "exec cmus-remote --prev";
            "XF86AudioNext" = "exec cmus-remote --next";
            "XF86AudioStop" = "exec cmus-remote --stop";

            # Control pulseaudio volume for default sink.
            # Ref: https://wiki.archlinux.org/index.php/PulseAudio#Keyboard_volume_control
            "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
            "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
	  };

        # NOTE: Border of i3-gaps windows is set via childBorder.
        colors = {
          focused         = { border = "#0000ff"; background = "#000000"; text = "#00ffed"; indicator = "#ffffff"; childBorder = "#0000ff"; };
          focusedInactive = { border = "#000000"; background = "#000000"; text = "#ffffff"; indicator = "#ffffff"; childBorder = "#000000"; };
          unfocused       = { border = "#000000"; background = "#222222"; text = "#999999"; indicator = "#ffffff"; childBorder = "#000000"; };
        };

        bars = [
          {
            position = "top";
            mode = "dock";

            fonts = [
              "Iosevka Medium 13"
            ];

            colors = {
              background = "#000000";
              statusline = "#cccccc";
              separator  = "#00ffea";

              focusedWorkspace   = {border = "#000000"; background = "#000000"; text = "#00fcff"; };
              activeWorkspace    = {border = "#000000"; background = "#000000"; text = "#cccccc"; };
              inactiveWorkspace  = {border = "#000000"; background = "#000000"; text = "#cccccc"; };
              urgentWorkspace    = {border = "#00ff00"; background = "#000000"; text = "#ffffff"; };
            };

            statusCommand = "while ${pkgs.barr}/bin/barr; do sleep 5; done";
            extraConfig = ''
              output DP-6
            '';
          }

          {
            position = "top";
            mode = "dock";

            fonts = [
              "Iosevka Medium 10"
            ];

            colors = {
              background = "#000000";
              statusline = "#cccccc";
              separator  = "#00ffea";

              focusedWorkspace   = {border = "#000000"; background = "#000000"; text = "#00fcff"; };
              activeWorkspace    = {border = "#000000"; background = "#000000"; text = "#cccccc"; };
              inactiveWorkspace  = {border = "#000000"; background = "#000000"; text = "#cccccc"; };
              urgentWorkspace    = {border = "#00ff00"; background = "#000000"; text = "#ffffff"; };
            };

            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3/i3status-rust_smallscreen.toml";
            extraConfig = ''
              output DP-4
            '';
          }
        ];

        startup = [
          { notification = false; command = "${pkgs.autorandr}/bin/autorandr -l eiffel"; }
          { notification = false; command = "i3-msg 'workspace 1; append_layout ~/.config/i3/workspace1.json'"; }

          { notification = false; command = "${cmd_set_wallpaper}"; }
          { notification = false; command = "${cmd_term_tmux}"; }
          { notification = false; command = "${cmd_browser}"; }
          { notification = false; command = "${cmd_slack}"; }

          # Set faster key repeat rate, inspired by EXWM.
          # Results in snappier Emacs usage.
          # See https://github.com/ch11ng/exwm/blob/master/xinitrc
          { notification = false; command = "xset r rate 200 60"; }
        ];

      };
    };
  };
}
