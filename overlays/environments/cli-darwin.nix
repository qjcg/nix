self: super:

{
  env-cli-darwin = super.pkgs.buildEnv {
    name = "env-cli-darwin";
    meta.priority = 0;
    paths = with super.pkgs; [
      go
      mdbook
      nix
      vscodium-with-extensions
      youtube-dl
    ];
  };
}
