self: super:

{
  env-cli-darwin = super.pkgs.buildEnv {
    name = "env-cli-darwin";
    meta.priority = 0;
    paths = with super.pkgs; [
      bat
      benthos
      cacert
      coreutils
      direnv
      fd
      git
      go
      gopass
      helm
      htop
      gitAndTools.hub
      jq
      k3d
      kubeseal
      lefthook
      loccount
      lorri
      ludo-bin
      mdbook
      mkcert
      neofetch
      neovim
      nethack
      nix
      nodejs
      rancher-cli
      ripgrep
      skaffold
      sqlite
      tekton-cli
      tig
      tmux
      tree
      vscodium-with-extensions
      watch
      youtube-dl
      ytop
    ];
  };
}
