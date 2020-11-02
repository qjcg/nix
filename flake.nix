# nixos-containers are an abstraction on top of `systemd-nspawn`.
# - [NixOS: Containers](https://nixos.org/manual/nixos/stable/#ch-containers)
# - [Arch Wiki: systemd-nspawn](https://wiki.archlinux.org/index.php/Systemd-nspawn)
# - [freedesktop.org: systemd-nspawn](https://www.freedesktop.org/software/systemd/man/systemd-nspawn.html)
# - [freedesktop.org: machinectl](https://www.freedesktop.org/software/systemd/man/machinectl.html)

# References:
# - [Nix Flakes, Part 3: Managing NixOS Systems](https://www.tweag.io/blog/2020-07-31-nixos-flakes/)
# - [NixOS: Modules](https://nixos.org/manual/nixos/stable/index.html#ex-module-syntax)
# - [Nixpkgs: Overlays](https://nixos.org/manual/nixpkgs/stable/#chap-overlays)
# - [Wiki: Flakes > Input schema](https://nixos.wiki/wiki/Flakes#Input_schema)
# - [Wiki: Flakes > Output schema](https://nixos.wiki/wiki/Flakes#Output_schema)
# - [home-manager: Nix Flakes](https://github.com/nix-community/home-manager#nix-flakes)

{
  description = "A flake for my nix configurations";

  inputs = {
    pkgs-stable.url = "github:nixos/nixpkgs/nixos-20.03";
    pkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    pkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-20.09-darwin";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "pkgs-darwin";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "pkgs-unstable";
    emacs.url = "github:nix-community/emacs-overlay";
    nur.url = "github:nix-community/NUR";

    sops.url = "github:mic92/sops-nix";
    sops.inputs.nixpkgs.follows = "pkgs-unstable";
    wayland.url = "github:colemickens/nixpkgs-wayland";
    wayland.inputs.nixpkgs.follows = "pkgs-unstable";
  };

  outputs = { self, ... }@inputs:
    let
      mySecrets = import ./secrets.nix;
      myOverlay = import ./overlays;
    in
    {

      # OVERLAYS

      # See:
      #   - https://nixos.wiki/wiki/Flakes#Importing_packages_from_multiple_channels
      overlays = {
        personal = myOverlay;

        thirdParty = final: prev: {
          home-manager = inputs.home-manager.legacyPackages."x86_64-linux";
          unstable = inputs.pkgs-unstable.legacyPackages."x86_64-linux";
        };
      };

      # A container using Overlays and Home-Manager (ohm).
      #
      # Example usage (as root):
      #   nixos-container create foobar --flake '.#test'
      #   nixos-container start foobar
      #   systemctl status container@foobar
      #   machinectl -l
      #   nixos-container update foobar --flake '.#test'
      #   nixos-container login foobar
      #   nixos-container root-login foobar
      #   nixos-container stop foobar
      #   nixos-container destroy foobar
      nixosConfigurations.ohm = inputs.pkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./modules/container.nix

          ({ config, pkgs, ... }: {

            # Use overlays defined in this flake.
            nixpkgs.overlays = [ self.overlays.personal self.overlays.thirdParty ];

            # Let 'nixos-version --json' know about the Git revision of this flake.
            system.configurationRevision = pkgs.lib.mkIf (self ? rev) self.rev;

            # Create a normal user for testing home-manager.
            users.users.jqhacker = {
              isNormalUser = true;
              password = "terrible";
            };

            # Import the home-manager NixOS module.
            imports = [ inputs.home-manager.nixosModules.home-manager ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Add home-manager configuration for our previously created user.
            # NOTE: The htop package should ONLY be available to jqhacker.
            home-manager.users.jqhacker = { home.packages = [ pkgs.htop ]; };

            # Set the container hostname.
            networking.hostName = "test";

            # Add some system packages.
            # NOTE: These packages should be available to all users.
            environment.systemPackages = with pkgs; [
              benthos
              neovim
              unstable.kubectl
            ];
          })

        ];
      };

      nixosConfigurations.workstation = inputs.pkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/container.nix
          ./modules/roles/workstation

          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [ self.overlays.personal self.overlays.thirdParty ];
            imports = [ inputs.home-manager.nixosModules.home-manager ];
          })
        ];
      };

      nixosConfigurations.luban = inputs.pkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./modules/machines/luban
          ./modules/users/john.nix
          ./modules/roles/workstation

          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [ self.overlays.thirdParty ];

            roles.workstation.enable = true;
            roles.workstation.games = true;
            roles.workstation.gnome = true;
            roles.workstation.sway = true;
          })

        ];
      };

      darwinConfigurations.mtlmp-jgosset1 = inputs.darwin.lib.darwinSystem
        {
          inputs = { secrets = mySecrets; };

          modules = [
            ./modules/roles/workstation
            inputs.home-manager.darwinModules.home-manager

            ({ config, home-manager, pkgs, secrets, ... }: {

              imports = [
                (import ./modules/users/hm-darwin_jgosset.nix {
                  inherit home-manager pkgs secrets;
                })
              ];

              nixpkgs.overlays = [ self.overlays.thirdParty ];
              users = mySecrets.users;

              roles.workstation.enable = true;
              roles.workstation.games = true;
              roles.workstation.gnome = true;
              roles.workstation.sway = true;
            })

          ];
        };

      templates = {
        container = {
          path = ./templates/container;
          description = "A flake providing a NixOS system container.";
        };

        shell = {
          path = ./templates/devshell;
          description = "A flake providing a development shell.";
        };

      };
    };
}
