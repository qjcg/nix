{ pkgs }:

{
  env-personal = pkgs.buildEnv {
    name = "env-personal";
    meta.priority = 0;
    paths = with pkgs;
      [ d4 horeb mtlcam ] ++ lib.lists.optionals stdenv.isLinux [ barr ];
  };
}
