{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    acpi
    curl
    elinks
    file
    git

    gnome3.gitg
    gnome3.gnome-tweak-tool
    gnome3.rhythmbox
    gnome3.shotwell
    lollypop
    olive-editor
    pitivi
    shotcut
    vocal

    htop
    iw
    openvpn
    pciutils
    psmisc
    tig
    tmux
    tree
    vim
    wget
  ];

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [  ];
  networking.firewall.allowedUDPPorts = [  ];

  programs.mtr.enable = true;

  security.sudo.wheelNeedsPassword = false;

  services.gnome3.games.enable = true;
  services.gpm.enable = true;
  services.printing.enable = true;
  services.openssh.enable = true;
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.displayManager.defaultSession = "gnome";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  virtualisation.docker.enable = true;
  #virtualisation.virtualbox.host.enable = true;

}
