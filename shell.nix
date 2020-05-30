with import <nixpkgs> {};
mkShell {
  buildInputs = [
    neovim
    nixfmt
  ];
}
