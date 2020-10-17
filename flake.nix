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
    pkgs-stable.url = "github:NixOS/nixpkgs/nixos-20.03";
    pkgs-stable-darwin.url = "github:NixOS/nixpkgs/nixpkgs-20.03-darwin";
    pkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/NUR";
    sops.url = "github:Mic92/sops-nix";
    wayland.url = "github:colemickens/nixpkgs-wayland";
  };

  outputs = { self, ... }@inputs:

    let secrets = import ./secrets.nix;
    in {

      # See:
      #   - https://nixos.wiki/wiki/Flakes#Importing_packages_from_multiple_channels
      overlays = {
        personal = import ./overlays;

        thirdParty = final: prev: {
          home-manager = inputs.home-manager.legacyPackages."x86_64-linux";
          unstable = inputs.pkgs-unstable.legacyPackages."x86_64-linux";
        };
      };

      # A container system for testing purposes.
      #
      # Features:
      #   - overlays
      #   - home-manager
      #
      # Example usage (as root):
      #   nixos-container create foobar --flake '.#test'
      #   nixos-container start foobar
      #   systemctl status container@foobar
      #   machinectl list
      #   nixos-container update foobar --flake '.#test'
      #   nixos-container login foobar
      #   nixos-container root-login foobar
      #   nixos-container stop foobar
      #   nixos-container destroy foobar
      nixosConfigurations.test = inputs.pkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ({ config, pkgs, ... }: {
            boot.isContainer = true;
            # Let 'nixos-version --json' know about the Git revision
            # of this flake.
            system.configurationRevision = pkgs.lib.mkIf (self ? rev) self.rev;

            networking.useDHCP = false;

            # Create a normal user for testing home-manager.
            users.users.jqhacker = {
              isNormalUser = true;
              password = "terrible";
            };

            # Import and use home-manager.
            imports = [ inputs.home-manager.nixosModules.home-manager ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jqhacker = { home.packages = [ pkgs.htop ]; };

            nixpkgs.overlays =
              [ self.overlays.personal self.overlays.thirdParty ];

            environment.systemPackages = with pkgs; [
              benthos
              neovim
              unstable.kubectl
            ];
          })
        ];
      };

      nixosConfigurations.luban = inputs.pkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [ self.overlays.thirdParty ];
            imports = [
              (import ./machines/luban { inherit config pkgs secrets; })

              (import ./roles/workstation-base { inherit pkgs; })
              (import ./roles/workstation-gnome { inherit pkgs; })
              (import ./roles/workstation-wayland { inherit pkgs; })

              (import ./users/john.nix { inherit pkgs secrets; })
            ];
          })
        ];
      };
    };
}
