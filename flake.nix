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
    bash-prompt-suffix = "(qjcg/nix shell) ";
  };

  inputs = {
    devshell.url = "github:numtide/devshell";
    emacs.url = "github:nix-community/emacs-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    guix.url = "github:emiller88/guix";
    guix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-20.09-darwin";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/NUR";
    wayland.url = "github:colemickens/nixpkgs-wayland";
    wayland.inputs.nixpkgs.follows = "nixpkgs";
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

          # Regex filters representing unsupported packages by system.
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
            let
              inherit (pkgs.devshell) mkShell;
              name = "devshell-nix";
            in
            # See https://github.com/numtide/devshell/blob/master/devshell.toml
            mkShell {
              inherit name;

              bash.extra = ''
                # A simple bash function as a proof-of-concept with mkShell.
                awesome() {
                  echo This is awesome $*
                }
              '';

              packages = with pkgs; [
                jg.envs.env-emacs
                jg.envs.env-nix
                nodejs # Installed as neovim dependency (avoids startup error message).
              ];

              # Review what's installed in your devshell via the `menu` command.
              commands = [
                {
                  name = "neovim";
                  package = "jg.overrides.neovim";
                  category = "editors";
                  help = "Vim, but new and shiny";
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
          lib = import ./lib { pkgs = prev; };
          inherit (lib) pkgsFromDir;
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
        devshell = {
          path = ./templates/devshell;
          description = "A flake providing a development shell.";
        };

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

        # See https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake-init.html#template-definitions
        defaultTemplate = self.templates.devshell;

      };

      nixosModules = {
        darwin = import ./modules/darwin;
        linux = import ./modules/linux;
      };

      # TODO: Organize this better. See e.g.: https://github.com/Mic92/dotfiles/blob/master/nixos/configurations.nix
      nixosConfigurations =
        let
          inherit (inputs.home-manager.lib.hm) dag;

          # Default overlays for Linux systems.
          linuxOverlays = [
            inputs.devshell.overlay
            inputs.emacs.overlay
            inputs.wayland.overlay
            self.overlay
          ];

          # Default modules for Linux systems.
          linuxModules = [
            inputs.home-manager.nixosModules.home-manager
            self.nixosModules.linux
          ];

          pkgsFunc =
            { system ? "x86_64-linux"
            , overlays ? linuxOverlays
            ,
            }:

            import inputs.nixpkgs { inherit overlays system; };

          myPkgs = pkgsFunc { };

          # A function wrapping nixosSystem with my preferred defaults.
          mkLinux =
            { system ? "x86_64-linux"
            , modules ? linuxModules
            , overlays ? linuxOverlays
            , extraModules ? [ ]
            ,
            }:

            inputs.nixpkgs.lib.nixosSystem {
              inherit system;
              modules = modules ++ extraModules ++ [{ nixpkgs.overlays = overlays; }];
            };
        in
        {

          # Usage:
          #   nixos-rebuild build-vm --flake .#workstationVM
          workstationVM = mkLinux {
            extraModules = [
              ./modules/users/flakeuser.nix

              # Stub values set to avoid errors during `nix flake check`.
              {
                fileSystems."/" = { device = ""; fsType = "ext4"; };
                boot.loader.grub.devices = [ "/dev/disk/by-label/myboot" ];
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
          #wrkc = workstation {
          #  modules = defaultModules ++ [
          #    self.nixosModules.container  # FIXME: Update to use ./modules/linux/container.nix
          #  ];
          #};

          luban = mkLinux {
            extraModules = [
              inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t460s
              ./modules/machines/luban
              (import ./modules/users/john.nix { inherit dag; pkgs = myPkgs; })
            ];
          };

          gemini = mkLinux {
            extraModules = [
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
              self.nixosModules.darwin
              ./modules/users/hm-darwin_jgosset.nix

              {
                nixpkgs.overlays = [
                  inputs.emacs.overlay
                  self.overlay
                ];

                roles.workstation.enable = true;
              }

            ];
          };
        };

    };
}
