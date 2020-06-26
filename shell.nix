with import <nixpkgs> { };

mkShell {
  pname = "shell-nixpkgs";

  buildInputs = [ fd fzf neovim nixfmt ];

  shellHook = let
    base_url = "https://api.github.com";
    repos =
      toString [ "rancher/k3c" "rancher/k3d" "bitnami-labs/sealed-secrets" ];
  in ''
    alias ls='ls --color --group-directories-first'

    releases() {
      for r in ${repos}; do
        url=${base_url}/repos/$r/releases/latest
        curl -s $url | jq '{tag_name, name, published_at}'
      done
    }
  '';
}
