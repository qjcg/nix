{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  nixpkgs.overlays = [
    (import ../../packages)

    # FIXME: Re-import without delve (not aarch64-supported).
    #(import ../../packages/neovim)
  ];
}
