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
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    pkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-20.09-darwin";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "pkgs-darwin";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    emacs.url = "github:nix-community/emacs-overlay";
    nur.url = "github:nix-community/NUR";

    sops.url = "github:mic92/sops-nix";
    sops.inputs.nixpkgs.follows = "nixpkgs";
    wayland.url = "github:colemickens/nixpkgs-wayland";
    wayland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import inputs.nixpkgs {
            system = "${system}";
            overlays = [
              inputs.emacs.overlay
            ];
          };
          customPackages = builtins.attrNames (builtins.readDir ./packages/custom);
        in
        {
          packages = pkgs.lib.attrsets.genAttrs customPackages (name:
            pkgs.callPackage (./packages/custom + "/${name}") { }
          );

          defaultPackage = self.packages.${system}.mtlcam;

          devShell = with pkgs;
            mkShell {
              name = "devshell-nix-qjcg";
              buildInputs = [
                hello
              ];
            };

          overlays = {
            personal = self.overlay;

            thirdParty = final: prev: {
              home-manager = inputs.home-manager.legacyPackages.${system};
              unstable = inputs.nixpkgs.legacyPackages.${system};
            };
          };
        }
      ) // {

      overlay = final: prev:
        let
          customPackages = builtins.attrNames (builtins.readDir ./packages/custom);
          # FIXME
          customEnvs = builtins.attrNames (builtins.readDir ./packages/environments);
        in
        {
          packages = prev.lib.attrsets.genAttrs customPackages (name:
            prev.callPackage (./packages/custom + "/${name}") { }
          );
          # FIXME
          envs = prev.lib.attrsets.genAttrs customEnvs (name:
            prev.callPackage (./packages/environments + "/${name}") { }
          );
        };

      templates = {
        container = {
          path = ./templates/container;
          description = "A flake providing a NixOS system container.";
        };

        lib = {
          path = ./templates/lib;
          description = "A flake providing a Nix library.";
        };

        package = {
          path = ./templates/package;
          description = "A flake providing a nix package.";
        };

        shell = {
          path = ./templates/devshell;
          description = "A flake providing a development shell.";
        };

      };

      nixosConfigurations =
        let
          mySecrets = import ./secrets.nix;
        in
        {

          workstation = inputs.nixpkgs.lib.nixosSystem {
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

          luban = inputs.nixpkgs.lib.nixosSystem {
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
        };

      darwinConfigurations =
        let
          mySecrets = import ./secrets.nix;
        in
        {
          mtlmp-jgosset1 = inputs.darwin.lib.darwinSystem
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
        };

    };
}
