with import <nixpkgs> {};

mkShell {
  buildInputs = [
    nixfmt
  ];
}
