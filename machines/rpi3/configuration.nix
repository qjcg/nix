{ config, pkgs, lib, ... }:

{
  hardware.enableRedistributableFirmware = true;

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  # This stanza is NEEDED for rpi3b+ wifi card to work
  # (taken from Nix wiki & tested 2019-04-26, kernel 5.0.9).
  #hardware.firmware = [
  #  (pkgs.stdenv.mkDerivation {
  #     name = "broadcom-rpi3bplus-extra";
  #     src = pkgs.fetchurl {
  #       url = "https://raw.githubusercontent.com/RPi-Distro/firmware-nonfree/b518de4/brcm/brcmfmac43455-sdio.txt";
  #       sha256 = "0r4bvwkm3fx60bbpwd83zbjganjnffiq1jkaj0h20bwdj9ysawg9";
  #     };
  #     phases = [ "installPhase" ];
  #     installPhase = ''
  #       mkdir -p $out/lib/firmware/brcm
  #       cp $src $out/lib/firmware/brcm/brcmfmac43455-sdio.txt
  #     '';
  #  })
  #];

  # File systems configuration for using the installer's partition layout
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  swapDevices = [ { device = "/swapfile"; size = 4096 ; } ];

  boot.loader.grub.enable = false;
  boot.cleanTmpDir = true;
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

  users.extraUsers = {
    john = {
      isNormalUser = true; 
      uid = 7777;
      extraGroups = [
      	"wheel"
      ];

      # FIXME: Use mkpasswd to generate a password
      #hashedPassword = "";
    };
  };

}

