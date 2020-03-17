{
  nix.nixPath = [
    { darwin-config = "\$HOME/.config/nixpkgs/configuration.nix"; }
    "\$HOME/.nix-defexpr/channels"
  ];
}
