{ pkgs, ... }:

with pkgs;
mkShell {
  buildInputs = [ hello htop ];
  shellHook = ''
    cat << END

    Nix shell from a flake! To use, run "nix develop"

    END
  '';
  AWESOME = "Yes indeed!";
}
