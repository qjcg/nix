self: super:

{
  env-go = super.pkgs.buildEnv {
    name = "env-go";
    meta.priority = 0;
    paths = with super.pkgs; [
      go
      delve
      #gopls
      gotools
      protobuf
      upx
    ];
  };
}
