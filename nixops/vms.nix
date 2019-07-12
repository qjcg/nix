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
        st
        tmux
        tree
        vim
      ];

      security.sudo.wheelNeedsPassword = false;

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
          dev = { gid = 7777; };
        };

        users = {
          dev = {
            createHome = true;
            home = "/home/dev";
            group = "dev";
            extraGroups = ["wheel"];
            description = "Developer";
          };
        };
      };
    };
}
