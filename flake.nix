# References:
#   - https://github.com/NixOS/rfcs/pull/49#issuecomment-511756456
{
  description = "A flake for my nix configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-20.03-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    emacs.url = "github:nix-community/emacs-overlay";
    wayland.url = "github:colemickens/nixpkgs-wayland";
  };

  outputs = { self, nixpkgs, nixpkgs-darwin, nixpkgs-unstable, emacs, wayland }:

    # See: https://github.com/ngi-nix/dhcpcanon/blob/master/flake.nix
    let
      # System types to support.
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = f:
        nixpkgs.lib.genAttrs supportedSystems (system: f system);

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        });
    in rec {
      # See nixos-rebuild(1).
      #nixosConfigurations = with nixpkgs.lib;
      #  let
      #    hosts = map (fname: builtins.head (builtins.match "(.*)\\.nix" fname))
      #      (builtins.attrNames (builtins.readDir ./hosts));
      #    mkHost = name:
      #      nixosSystem {
      #        system = "x86_64-linux";
      #        modules = [ (import ./default.nix) ];
      #        specialArgs = { inherit inputs name; };
      #      };
      #  in genAttrs hosts mkHost;

      overlay = final: prev: { go-4d = final.callPackage ./packages/4d; };

      # Provide some binary packages for selected system types.
      packages =
        forAllSystems (system: { inherit (nixpkgsFor.${system}) go-4d; });

      nixosConfigurations = { luban = { }; };

    };
}
