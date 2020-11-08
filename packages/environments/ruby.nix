final: prev:

with prev;
{
  env-ruby = buildEnv {
    name = "env-ruby";
    meta.priority = 0;
    paths = [
      bundix
      pry
      rubyPackages.pry-doc
      ruby
    ];
  };
}
