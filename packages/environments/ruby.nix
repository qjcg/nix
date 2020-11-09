{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-ruby";
  paths = [
    bundix
    pry
    rubyPackages.pry-doc
    ruby
  ];
  meta = {
    priority = 0;
    description = "An environment for Ruby development";
  };
}
