{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    env-k8s
    env-neovim
    env-nix
    env-personal
    env-shell
    env-tools
  ];

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];

  programs.mtr.enable = true;

  security.sudo.wheelNeedsPassword = false;

  services.gpm.enable = true;
  services.printing.enable = true;
  services.openssh.enable = true;
  services.resolved.dnssec = "false";

  virtualisation.docker.enable = true;
  #virtualisation.virtualbox.host.enable = true;

}
