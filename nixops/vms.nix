# Ref: https://nixos.org/nixops/manual/#idm140737322662048
{
  network.description = "Workstation Network";

  workstation =
    { config, pkgs, ... }:

    {
      deployment = {
        targetEnv = "virtualbox";
        virtualbox = {
          memorySize = 2048;
          vcpu = 2;
          vmFlags = [
            "--vram" "256"
          ];
        };
      };

      environment.systemPackages = with pkgs; [
        git
        home-manager
        psmisc
        rsync
        tmux
        tree
        vim
      ];

      services.xserver = {
        enable = true;
        layout = "us,ca";
        xkbOptions = "grp:shifts_toggle";

        displayManager.lightdm = {
          enable = true;
        };

        windowManager.i3 = {
          enable = true;
          package = pkgs.i3-gaps;
        };
      };

      time.timeZone = "America/Montreal";

      users = {
        groups = {
          john = { gid = 7777; };
        };

        users = {
          john = { createHome = true; home = "/home/john"; shell = "/bin/sh"; group = "john"; extraGroups = ["wheel"]; description = "John Gosset"; };
        };
      };
    };
}
