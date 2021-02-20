{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-python";
  paths = [
    (python38.withPackages (ps:
      with ps; [
        ansible
        #ansible-lint
        beautifulsoup4
        black
        cookiecutter
        ipython
        mypy
        #poetry
        pylint
        requests
      ]))
  ];
  meta = {
    priority = 0;
    description = "An environment for Python development";
  };
}
