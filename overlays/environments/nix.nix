self: super:

{
  env-nix = super.pkgs.buildEnv {
    name = "env-nix";
    meta.priority = 0;
    paths = with super.pkgs; [
      #cachix # NOTE: Requires a RIDICULOUSLY long ghc compilation.
      direnv
      lorri
      nix-bash-completions
      nix-index
      #nixops # NOTE: Broken build 2020-07-06
      nixpkgs-fmt
    ];
  };
}
