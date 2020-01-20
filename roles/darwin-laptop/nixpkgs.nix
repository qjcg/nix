{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  nixpkgs.overlays = [
    (import ../../packages)
    (import ../../packages/neovim)
    (import ../../packages/overrides.nix)
  ];
}
