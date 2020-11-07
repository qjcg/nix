{ pkgs }:

{
  env-go = pkgs.buildEnv {
    name = "env-go";
    meta.priority = 0;
    paths = with pkgs; [
      go
      gohack
      delve
      golangci-lint
      gopls
      #gotools
      protobuf
      upx
    ];
  };
}
