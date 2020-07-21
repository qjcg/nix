self: super:

{
  env-ruby = super.pkgs.buildEnv {
    name = "env-ruby";
    meta.priority = 0;
    paths = with super.pkgs; [ bundix pry rubyPackages.pry-doc ruby ];
  };
}
