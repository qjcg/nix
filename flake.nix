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
    nixos-hardware.url = "github:NixOS/nixos-hardware";
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
              self.overlay
              inputs.emacs.overlay
            ];
          };

          unsupportedDarwin = "freetube|ruffle"; # Filter these names out on Darwin.
        in
        {
          packages =
            let
              custom = pkgs.lib.attrsets.genAttrs

                # Filter out packages that are unsupported when on darwin systems.
                (builtins.filter
                  (name:
                    !(
                      !isNull (builtins.match unsupportedDarwin name) &&
                      "${system}" == "x86_64-darwin"
                    ))
                  (builtins.attrNames (builtins.readDir ./packages/custom))
                )
                (name: pkgs.callPackage (./packages/custom + "/${name}") { });

              environments = {
                env-financial = pkgs.callPackage ./packages/environments/financial.nix { };
                env-go = pkgs.callPackage ./packages/environments/go.nix { };
                env-k8s = pkgs.callPackage ./packages/environments/k8s.nix { };
                env-multimedia = pkgs.callPackage ./packages/environments/multimedia.nix { };
                env-nix = pkgs.callPackage ./packages/environments/nix.nix { };
                env-personal = pkgs.callPackage ./packages/environments/personal.nix { };
                env-python = pkgs.callPackage ./packages/environments/python.nix { };
                env-ruby = pkgs.callPackage ./packages/environments/ruby.nix { };
                env-shell = pkgs.callPackage ./packages/environments/shell.nix { };
                env-tools = pkgs.callPackage ./packages/environments/tools.nix { };
              };

              overrides =
                let
                  pkgs = import inputs.nixpkgs {
                    system = "${system}";
                    overlays = [
                      inputs.emacs.overlay
                      inputs.wayland.overlay
                    ];
                  };
                in
                {
                  dunst = pkgs.callPackage ./packages/overrides/dunst { };
                  emacs = pkgs.callPackage ./packages/overrides/emacs { };
                  neovim = pkgs.callPackage ./packages/overrides/neovim { };
                  retroarch = pkgs.callPackage ./packages/overrides/retroarch { };
                  st = pkgs.callPackage ./packages/overrides/st { };
                  sxiv = pkgs.callPackage ./packages/overrides/sxiv { };
                  vscodium-with-extensions = pkgs.callPackage ./packages/overrides/vscodium-with-extensions { };
                  wayfire = pkgs.callPackage ./packages/overrides/wayfire { };
                };
            in
            custom // environments // overrides;

          defaultPackage = self.packages.${system}.mtlcam;

          devShell =
            with inputs.nixpkgs.legacyPackages.${system};
            with self.packages.${system};
            pkgs.mkShell {
              name = "devshell-nix-qjcg";
              buildInputs = [
                emacs
                nixpkgs-fmt
              ];
            };

          checks = {
            build = self.defaultPackage.${system};
          };
        }
      ) // {

      lib = import ./lib;

      overlay = import ./packages;

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

      # See:
      #   - https://github.com/NixOS/nix/commit/343239fc8a1993f707a990c2cd54a41f1fa3de99
      #   - https://github.com/NixOS/nix/blob/master/src/nix/develop.md#description
      nixConfig = {
        bash-prompt = "\u@\h \W \$ ";
        bash-prompt-suffix = " _NIXY_ ";
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
