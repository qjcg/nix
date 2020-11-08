final: prev:

with prev;
{
  env-go = buildEnv {
    name = "env-go";
    meta.priority = 0;
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
  };
}
