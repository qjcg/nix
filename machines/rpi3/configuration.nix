{ config, pkgs, lib, ... }:

{
  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  swapDevices = [ { device = "/swapfile"; size = 4096 ; } ];

  hardware.enableRedistributableFirmware = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # A bunch of boot parameters needed for optimal runtime on RPi 3b+
  boot.kernelParams = ["cma=256M"];
  boot.loader.raspberryPi.enable = true;
  boot.loader.raspberryPi.version = 3;
  boot.loader.raspberryPi.uboot.enable = true;
  boot.loader.raspberryPi.uboot.configurationLimit = 2;
  boot.loader.raspberryPi.firmwareConfig = ''
    gpu_mem=256
  '';
  boot.loader.grub.enable = false;

  networking.wireless.iwd.enable = true;

  environment.systemPackages = with pkgs; [
    git
    home-manager
    htop
    mkpasswd
    neofetch
    psmisc
    raspberrypi-tools
    tmux
    tree
    vim
  ];

  environment.shellAliases = {
    # FIXME: allow PER-PACKAGE listing as function?
    pkgList = "nix-env -q --out-path | awk '{print $2}' | xargs tree";
  };

  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  programs.vim.defaultEditor = true;
  programs.xonsh.enable = true;

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";

  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  time.timeZone = "America/Montreal";

  users.users = {
    john = {
      isNormalUser = true; 
      uid = 7777;
      extraGroups = [
      	"wheel"
      ];
    };
  };

}
