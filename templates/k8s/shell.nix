{ pkgs ? <nixpkgs>, useVim ? false, ... }:

with pkgs;

mkShell {
  buildInputs = [ age argo cue lefthook kubectl kubectx kubeseal sops tanka vault ]
    ++ lib.lists.optionals useVim [ vim ];

  shellHook = ''
    alias k='kubectl'

    cat << END

    Welcome to this K8s development environment!

    END
  '';

  VAULT_ADDR = "https://example.com:8200";
  VAULT_NAMESPACE = "devteam";
  #VAULT_CACERT = builtins.fetchurl {
  #  url = "https://example.com/example-ca.pem";
  #  sha256 = pkgs.lib.fakeSha256;
  #};
}
