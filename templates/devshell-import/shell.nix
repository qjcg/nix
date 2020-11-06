{ pkgs ? <nixpkgs>, ... }:

with pkgs;
mkShell {
  name = "devshell-myapp";
  buildInputs = [ hello ];
  shellHook = ''
    cat << END

    Nix shell from a flake! To use, run "nix develop"

    END
  '';
  AWESOME = "Yes indeed!";
}
