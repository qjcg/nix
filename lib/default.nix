let
  inherit (builtins) getFlake trace;
in
{
  debug = rec {
    nixpkgs-unstable = getFlake "github:nixos/nixpkgs/nixpkgs-unstable";
    thisFlake = getFlake (toString ../.);
    nixpkgsWithOverlay = import nixpkgs-unstable {
      overlays = [ thisFlake.overlay ];
    };

    pk = p: nixpkgsWithOverlay.packages.${p} null;
  };
}
