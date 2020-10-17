# References:
# - [Nix Flakes, Part 3: Managing NixOS Systems](https://www.tweag.io/blog/2020-07-31-nixos-flakes/)
# - [NixOS: Modules](https://nixos.org/manual/nixos/stable/index.html#ex-module-syntax)
# - [NixOS: Containers](https://nixos.org/manual/nixos/stable/#ch-containers)
# - [Nixpkgs: Overlays](https://nixos.org/manual/nixpkgs/stable/#chap-overlays)
# - [Wiki: Flakes > Input schema](https://nixos.wiki/wiki/Flakes#Input_schema)
# - [Wiki: Flakes > Output schema](https://nixos.wiki/wiki/Flakes#Output_schema)

{
  description = "A flake for my nix configurations";

  inputs = {
    pkgs-stable.url = "github:NixOS/nixpkgs/nixos-20.03";
    pkgs-stable-darwin.url = "github:NixOS/nixpkgs/nixpkgs-20.03-darwin";
    pkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/bqv-flakes";
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

      nixosConfigurations.containerTest = inputs.pkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ({ config, pkgs, ... }: {
            boot.isContainer = true;

            nixpkgs.overlays =
              [ self.overlays.personal self.overlays.thirdParty ];
            environment.systemPackages = with pkgs; [ benthos neovim ];
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
