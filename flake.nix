# References:
# - [Nix Flakes, Part 3: Managing NixOS Systems](https://www.tweag.io/blog/2020-07-31-nixos-flakes/)
# - [NixOS: Modules](https://nixos.org/manual/nixos/stable/index.html#ex-module-syntax)
# - [Nixpkgs: Overlays](https://nixos.org/manual/nixpkgs/stable/#chap-overlays)
# - [Wiki: Flakes > Input schema](https://nixos.wiki/wiki/Flakes#Input_schema)
# - [Wiki: Flakes > Output schema](https://nixos.wiki/wiki/Flakes#Output_schema)
# - [home-manager: Nix Flakes](https://github.com/nix-community/home-manager#nix-flakes)

{
  description = "A flake for my nix configurations";

  # NOTE: This works with nix develop.
  # See:
  #   - https://github.com/NixOS/nix/commit/343239fc8a1993f707a990c2cd54a41f1fa3de99
  #   - https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-develop.html#description
  nixConfig = {
    bash-prompt = "\\u@\\h \\W \\$ ";
    bash-prompt-suffix = "(nix develop) ";
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
    wayland.url = "github:colemickens/nixpkgs-wayland";
  };

  outputs = { self, ... }@inputs:
    inputs.flake-utils.lib.eachSystem [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-linux"
    ]
      (system:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              inputs.devshell.overlay
              inputs.emacs.overlay
              inputs.wayland.overlay
              self.overlay
            ];
            config.allowUnfree = true;
            config.allowUnsupportedSystem = true;
          };

          myPkgs =
            pkgs.jg.custom //
            pkgs.jg.docker //
            pkgs.jg.envs //
            pkgs.jg.newer //
            pkgs.jg.overrides;

          # Regex filters representing unsopported packages by system.
          # To do no filtering (let everything through), set system value to null.
          filters = {
            x86_64-linux = null;
            x86_64-darwin = "docker-.*|env-desktop|freetube|retroarch|sbagen|sxiv|wayfire";
            aarch64-linux = "env-multimedia|sbagen";
          };
        in
        {
          # NOTE: For "packages" output, top-level attr values MUST all be derivations to pass `nix flake check`.
          packages = self.lib.filterPackages {
            attrs = myPkgs;
            regex = filters.${system};
          };
          defaultPackage = pkgs.jg.custom.mtlcam;

          devShell =
            with pkgs;
            let
              name = "devshell-nix-qjcg";
            in
            # See https://github.com/numtide/devshell/blob/master/devshell.toml
            devshell.mkShell {
              inherit name;

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
            build = self.defaultPackage.${system}; # FIXME: Redundant. Add more interesting checks.
          };

        }
      ) // {

      lib = import ./lib { pkgs = inputs.nixpkgs; };

      overlay =
        final: prev:
        let
          inherit (builtins) attrNames readDir;
          inherit (prev) callPackage;
          inherit (prev.lib.attrsets) genAttrs;

          # pkgsFromDir creates a {pname: derivation} attrset given an input dir.
          pkgsFromDir = dir:
            # input: A directory path. The directory should contain nix package subdirs.
            # output: An attrset mapping package names to package derivations.
            genAttrs
              (attrNames (readDir dir))
              (name: callPackage (dir + "/${name}") { });
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
      nixosConfigurations =
        let
          inherit (inputs.home-manager.lib.hm) dag;

          defaultOverlays = [
            inputs.devshell.overlay
            inputs.emacs.overlay
            inputs.wayland.overlay
            self.overlay
          ];

          defaultModules = [
            inputs.home-manager.nixosModules.home-manager
            self.nixosModules.workstation

            {
              roles.workstation.enable = true;
              roles.workstation.desktop = true;
              roles.workstation.games = true;
              roles.workstation.gnome = true;
              roles.workstation.sway = true;
            }
          ];

          myPkgsFunc =
            { system ? "x86_64-linux"
            , overlays ? defaultOverlays
            }:

            import inputs.nixpkgs { inherit overlays system; };

          myPkgs = myPkgsFunc { };

          workstation =
            { system ? "x86_64-linux"
            , modules ? defaultModules
            , overlays ? defaultOverlays
            }:

            inputs.nixpkgs.lib.nixosSystem {
              inherit system;
              modules = modules ++ [{ nixpkgs.overlays = overlays; }];
            };
        in
        {

          # Usage:
          #   nixos-rebuild build-vm --flake .#workstationVM
          workstationVM = workstation {
            modules = defaultModules ++ [
              ./modules/users/flakeuser.nix
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
          wrkc = workstation {
            modules = defaultModules ++ [
              self.nixosModules.container
            ];
          };

          luban = workstation {
            modules = defaultModules ++ [
              inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t460s
              ./modules/machines/luban
              (import ./modules/users/john.nix { inherit dag; pkgs = myPkgs; })
            ];
          };

          gemini = workstation {
            modules = defaultModules ++ [
              ./modules/machines/gemini
              (import ./modules/users/john.nix { inherit dag; pkgs = myPkgs; })
            ];
          };

        };

      darwinConfigurations =
        {
          mtlmp-jgosset1 = inputs.nix-darwin.lib.darwinSystem {
            modules = [
              inputs.home-manager.darwinModules.home-manager

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
