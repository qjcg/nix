{
  pkgs,
  lib,

  secrets,
  ...
}:

{
  fonts.fontconfig.enable = true;
  manual.html.enable = true;

  gtk = {
    enable = true;
  };


  home = {
    language = {
      base = "en_US.utf8";
    };

    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
      PAGER = "less";
      VISUAL = "nvim";

      NIX_PATH = "nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs";

      QT_PLATFORMTHEME = "qt5ct";
      QT_PLATFORM_PLUGIN = "qt5ct";
      QT_QPA_PLATFORMTHEME = "qt5ct";

      MAILRC = "$HOME/.config/s-nail/mailrc";
    };

    keyboard = {
      layout = "us,ca";
      model = "pc105";
      options = ["grp:shifts_toggle"];
    };

    packages = with pkgs; [ env-workstation ];

  };

}
