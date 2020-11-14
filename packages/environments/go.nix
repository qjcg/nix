{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-go";
  paths = [
    go
    gohack
    delve
    golangci-lint
    gopls
    #gotools
    protobuf
    upx
  ];
  meta = {
    description = "An environment for Go development";
    priority = 0;
  };
}
