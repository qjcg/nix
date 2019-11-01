# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  secrets = import ../../secrets.nix;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  hardware.cpu.intel.updateMicrocode = true;

  boot.kernelPackages = pkgs.linuxPackages_latest ;
  boot.extraModulePackages = with config.boot.kernelPackages ; [
    bcc

    # TODO: Uncomment when working again!
    #bpftrace

    sysdig
    wireguard
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.systemd-boot.consoleMode = "0";
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/disk/by-uuid/8a54628e-f640-4fa8-9825-e346d132de08";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  networking.hostName = "luban";

  # wpa_supplicant
  networking.wireless.enable = true;
  networking.wireless.userControlled.enable = true;

  # iwd
  # NOTE: Disabled due to DRW EAP-PEAP not being usable without a certificate (that doesn't seem to be provided).
  #networking.wireless.iwd.enable = true;

  i18n = {
    consoleFont = "iso01-12x22";
    consoleKeyMap = "us";
    defaultLocale = "en_CA.UTF-8";
  };

  time.timeZone = secrets.timeZone;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    acpi
    curl
    git
    iw
    openvpn
    pciutils
    psmisc
    tree
    vim
    wget
    wpa_supplicant # TODO: Remove once iwd working perfectly.
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.slock.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [  ];
  networking.firewall.allowedUDPPorts = [  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;

  # TODO: Get BOSE headphones working (no success yet!)
  # See: https://askubuntu.com/a/833323
  #hardware.bluetooth.extraConfig = ''
  #  [General]
  #  ControllerMode = bredr
  #'';

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.greeters.enso.enable = true;

  # FIXME: Re-enable i3 via home-manager, not system-wide config.
  # The following i3 config was added in 2019-09 to avoid an issue where lightdm hangs after successful auth, starting NO window manager.
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  security.sudo = secrets.sudo;
  users.users = secrets.users;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

}
