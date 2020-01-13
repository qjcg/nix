{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.overlays = [
    (import ../../overlays/4d)
    (import ../../overlays/glooctl)
    (import ../../overlays/hey)
    (import ../../overlays/horeb)
    (import ../../overlays/k3d)
    (import ../../overlays/mtlcam)
    (import ../../overlays/neovim)
    (import ../../overlays/skaffold)
    (import ../../overlays/overrides.nix)
  ];
}
