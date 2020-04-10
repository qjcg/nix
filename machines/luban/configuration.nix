{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  hardware.cpu.intel.updateMicrocode = true;

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/8a54628e-f640-4fa8-9825-e346d132de08";
      preLVM = true;
      allowDiscards = true;
    };
  };

  boot.plymouth.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest ;
  boot.extraModulePackages = with config.boot.kernelPackages ; [
    bcc
    #bpftrace
    #sysdig
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 2;
  boot.loader.systemd-boot.consoleMode = "0";
  boot.loader.efi.canTouchEfiVariables = true;

  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };

  i18n = {
    defaultLocale = "en_CA.UTF-8";
  };

  networking.hostName = "luban";
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
  networking.useNetworkd = true;
  services.resolved.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;

  time.timeZone = "America/Montreal";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

}
