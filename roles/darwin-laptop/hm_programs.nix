{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        background_opacity = 0.85;
        colors = {
          cursor.cursor = "0xe502d2";
        };
        font = {
          normal.family = "Iosevka";
          size = 14;
        };
        shell.program = "/run/current-system/sw/bin/xonsh";
        window.dimensions = {
          columns = 160;
          lines = 40;
        };
      };
    };
  };
}
