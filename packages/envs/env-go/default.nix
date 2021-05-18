{ pkgs, ... }:
let
  inherit (pkgs) buildEnv;
  inherit (pkgs.lib.lists) optionals;
  inherit (pkgs.stdenv) isAarch64;
in
buildEnv {
  name = "env-go";
  paths = with pkgs; [
    jg.custom.gohack

    go
    godef
    golangci-lint
    gomacro
    gopls
    gotools
    protobuf
    upx
  ] ++ optionals (!isAarch64) [
    delve
  ];
  meta = {
    description = "An environment for Go development";
    priority = 0;
  };
}
