{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    d4
    git
    home-manager
    htop
    mkpasswd
    neofetch
    neovim
    psmisc
    raspberrypi-tools
    tig
    tmux
    tree
    vim
  ];

  environment.shellAliases = {
    # FIXME: allow PER-PACKAGE listing as function?
    pkgList = "nix-env -q --out-path | awk '{print $2}' | xargs tree";
  };

}
