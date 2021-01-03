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

  # See:
  #   - https://github.com/NixOS/nix/commit/343239fc8a1993f707a990c2cd54a41f1fa3de99
  #   - https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-develop.html#description
  nixConfig = {
    bash-prompt = "\u@\h \W \$ ";
    bash-prompt-suffix = " _NIXY_ ";
  };

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    pkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-20.09-darwin";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "pkgs-darwin";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    emacs.url = "github:nix-community/emacs-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nur.url = "github:nix-community/NUR";

    sops.url = "github:mic92/sops-nix";
    sops.inputs.nixpkgs.follows = "nixpkgs";
    wayland.url = "github:colemickens/nixpkgs-wayland";
    wayland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, ... }@inputs:
    let
      # Each attr key must be a system name.
      # Each attr value must be a regex of UNsupported package names.
      unsupportedOnSystem = {
        "aarch64-linux" = "delve";
        "x86_64-darwin" = "freetube|ruffle";
      };
    in
    inputs.flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import inputs.nixpkgs {
            system = "${system}";
            overlays = [
              inputs.emacs.overlay
              inputs.wayland.overlay
              self.overlay
            ];
          };
        in
        {
          #packages =
          #  let
          #    custom = pkgs.lib.attrsets.genAttrs

          #      # Filter out packages that are unsupported when on darwin systems.
          #      (builtins.filter
          #        (name:
          #          !(
          #            !isNull (builtins.match unsupportedDarwin name) &&
          #            "${system}" == "x86_64-darwin"
          #          ))
          #        (builtins.attrNames (builtins.readDir ./packages/custom))
          #      )
          #      (name: pkgs.callPackage (./packages/custom + "/${name}") { });

          #  in
          #  custom // environments // overrides;

          # NOTE: For "packages" output, top-level attr values MUST all be derivations to pass `nix flake check`.
          packages = pkgs.jg.custom // pkgs.jg.envs // pkgs.jg.overrides;
          defaultPackage = pkgs.jg.custom.mtlcam;

          devShell =
            with pkgs;
            mkShell {
              name = "devshell-nix-qjcg";
              buildInputs = [
                jg.overrides.emacs
                jg.overrides.neovim
                jg.envs.env-nix
              ];
            };

          checks = {
            build = self.defaultPackage.${system};
          };

        }
      ) // {

      lib = import ./lib;

      overlay =
        final: prev:
        let
          # pkgsFromDir creates a {pname: derivation} attrset given 
          pkgsFromDir = dir:
            # input: A directory path. The directory should contain nix package subdirs.
            # output: An attrset mapping package names to package derivations.
            prev.lib.attrsets.genAttrs
              (builtins.attrNames (builtins.readDir dir))
              (name: prev.callPackage (dir + "/${name}") { });
        in
        {
          # Put my packages in their own attrset to easily
          # distinguish them from upstream packages.
          jg = {
            custom = pkgsFromDir ./packages/custom;
            envs = pkgsFromDir ./packages/envs;
            overrides = pkgsFromDir ./packages/overrides;
          };
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

      nixosModules = {
        container = import ./modules/container.nix;
        workstation = import ./modules/roles/workstation;
      };

      # TODO: Organize this better. See e.g.: https://github.com/Mic92/dotfiles/blob/master/nixos/configurations.nix
      nixosConfigurations = {

        # Usage:
        #   nixos-rebuild build-vm --flake .#workstationVM
        workstationVM = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.sops.nixosModules.sops

            self.nixosModules.workstation
            ./modules/users/flakeuser.nix

            {
              nixpkgs.overlays = [ self.overlay ];

              home-manager.useUserPackages = true;
              roles.workstation.enable = true;
              roles.workstation.games = true;
              roles.workstation.gnome = true;
              roles.workstation.sway = false;
            }

          ];
        };

        # Usage:
        #   nixos-container create myWorkstation --flake .#workstationContainer
        #   nixos-container start myWorkstation
        #   nixos-container root-login myWorkstation
        #   nixos-container destroy myWorkstation
        workstationContainer = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.sops.nixosModules.sops

            self.nixosModules.container
            self.nixosModules.workstation

            ({ config, lib, pkgs, ... }: {
              nixpkgs.overlays = [ self.overlay ];

              roles.workstation.enable = true;
              roles.workstation.games = true;
              roles.workstation.gnome = true;
              roles.workstation.sway = false;
            })
          ];
        };

        luban = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t460s

            ./modules/machines/luban
            ./modules/users/john.nix

            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [ self.overlay ];

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

                  nixpkgs.overlays = [ self.overlay ];
                  users = mySecrets.users;

                  roles.workstation.enable = true;
                  roles.workstation.games = true;
                })

              ];
            };
        };

    };
}
