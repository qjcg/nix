with import <nixpkgs> {};

mkShell {
  buildInputs = [
    fd
    fzf
    neovim
    nixfmt
  ];
}
