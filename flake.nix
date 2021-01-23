# References:
# - [Nix Flakes, Part 3: Managing NixOS Systems](https://www.tweag.io/blog/2020-07-31-nixos-flakes/)
# - [NixOS: Modules](https://nixos.org/manual/nixos/stable/index.html#ex-module-syntax)
# - [Nixpkgs: Overlays](https://nixos.org/manual/nixpkgs/stable/#chap-overlays)
# - [Wiki: Flakes > Input schema](https://nixos.wiki/wiki/Flakes#Input_schema)
# - [Wiki: Flakes > Output schema](https://nixos.wiki/wiki/Flakes#Output_schema)
# - [home-manager: Nix Flakes](https://github.com/nix-community/home-manager#nix-flakes)

{
  description = "A flake for my nix configurations";

  # NOTE: nixConfig doesn't seem to be working yet (2021-01-03), but it should work eventually.
  # See:
  #   - https://github.com/NixOS/nix/commit/343239fc8a1993f707a990c2cd54a41f1fa3de99
  #   - https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-develop.html#description
  nixConfig = {
    bash-prompt = "\u@\h \W \$ ";
    bash-prompt-suffix = " _NIX_ ";
  };

  inputs = {
    devshell.url = "github:numtide/devshell";
    emacs.url = "github:nix-community/emacs-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    guix.url = "github:emiller88/guix";
    home-manager.url = "github:nix-community/home-manager";
    nix-darwin.url = "github:lnl7/nix-darwin";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-20.09-darwin";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:mic92/sops-nix";
    wayland.url = "github:colemickens/nixpkgs-wayland";
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
              inputs.devshell.overlay
              inputs.emacs.overlay
              inputs.wayland.overlay
              self.overlay
            ];
          };
        in
        {
          # NOTE: For "packages" output, top-level attr values MUST all be derivations to pass `nix flake check`.
          packages = pkgs.jg.custom // pkgs.jg.docker // pkgs.jg.envs // pkgs.jg.newer // pkgs.jg.overrides;
          defaultPackage = pkgs.jg.custom.mtlcam;

          devShell =
            with pkgs;

            # See https://github.com/numtide/devshell/blob/master/devshell.toml
            mkDevShell rec {
              name = "devshell-nix-qjcg";

              motd = ''

                Welcome to the ${name} devshell!
              '';

              bash.extra = ''
                # A simple bash function as a proof-of-concept with mkDevShell.
                awesome() {
                  echo This is awesome $*
                }
              '';

              packages = [
                jg.envs.env-nix
                nodejs-14_x # installed as neovim dependency (avoids startup error message)
              ];

              # Review what's installed in your devshell via the `menu` command.
              commands = [
                {
                  help = "used to format nix code";
                  name = "nixpkgs-fmt";
                  package = "nixpkgs-fmt";
                  category = "formatters";
                }
                {
                  help = "A sort of hybrid between Windows Notepad, a monolithic-kernel operating system, and the International Space Station.";
                  name = "emacs";
                  package = "jg.overrides.emacs";
                  category = "editors";
                }
                {
                  help = "Vim, but new and stuff";
                  name = "neovim";
                  package = "jg.overrides.neovim";
                  category = "editors";
                }
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
          # pkgsFromDir creates a {pname: derivation} attrset given an input dir.
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
            docker = pkgsFromDir ./packages/docker;
            envs = pkgsFromDir ./packages/envs;
            newer = pkgsFromDir ./packages/newer;
            overrides = pkgsFromDir ./packages/overrides;
          };
        };

      templates = {
        docker = {
          path = ./templates/docker;
          description = "A flake providing a docker container image.";
        };

        oci = {
          path = ./templates/oci;
          description = "A flake providing an OCI container image.";
        };

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

        # See https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake-init.html#template-definitions
        defaultTemplate = self.templates.shell;

      };

      nixosModules = {
        container = import ./modules/container;
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
            inputs.sops-nix.nixosModules.sops

            self.nixosModules.workstation
            ./modules/users/flakeuser.nix

            {
              nixpkgs.overlays = [
                inputs.devshell.overlay
                inputs.emacs.overlay
                inputs.wayland.overlay
                self.overlay
              ];

              home-manager.useUserPackages = true;
              roles.workstation.enable = true;
              roles.workstation.games = true;
              roles.workstation.gnome = true;
              roles.workstation.sway = true;
            }

          ];
        };

        # nixos-containers are an abstraction on top of `systemd-nspawn`.
        # - [NixOS: Containers](https://nixos.org/manual/nixos/stable/#ch-containers)
        # - [Arch Wiki: systemd-nspawn](https://wiki.archlinux.org/index.php/Systemd-nspawn)
        # - [freedesktop.org: systemd-nspawn](https://www.freedesktop.org/software/systemd/man/systemd-nspawn.html)
        # - [freedesktop.org: machinectl](https://www.freedesktop.org/software/systemd/man/machinectl.html)
        # Usage:
        #   nixos-container create myWorkstation --flake .#wrkc
        #   nixos-container start myWorkstation
        #   nixos-container root-login myWorkstation
        #   nixos-container destroy myWorkstation
        wrkc = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.sops-nix.nixosModules.sops

            self.nixosModules.container
            self.nixosModules.workstation

            {
              nixpkgs.overlays = [
                inputs.devshell.overlay
                inputs.emacs.overlay
                inputs.wayland.overlay
                self.overlay
              ];

              roles.workstation.enable = true;
              roles.workstation.games = true;
              roles.workstation.gnome = true;
              roles.workstation.sway = true;
            }
          ];
        };

        luban = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t460s
            inputs.sops-nix.nixosModules.sops
            self.nixosModules.workstation

            ./modules/machines/luban
            ./modules/users/john.nix

            {
              nixpkgs.overlays = [
                inputs.devshell.overlay
                inputs.emacs.overlay
                inputs.wayland.overlay

                self.overlay
              ];

              roles.workstation.enable = true;
              roles.workstation.desktop = true;
              roles.workstation.games = true;
              roles.workstation.gnome = true;
              roles.workstation.sway = true;
            }

          ];
        };
      };

      darwinConfigurations =
        {
          mtlmp-jgosset1 = inputs.nix-darwin.lib.darwinSystem {
            modules = [
              inputs.home-manager.darwinModules.home-manager
              inputs.sops-nix.nixosModules.sops

              self.nixosModules.workstation
              ./modules/users/hm-darwin_jgosset.nix

              {

                nixpkgs.overlays = [
                  inputs.devshell.overlay
                  inputs.emacs.overlay
                  inputs.wayland.overlay
                  self.overlay
                ];

                roles.workstation.enable = true;
              }

            ];
          };
        };

    };
}
