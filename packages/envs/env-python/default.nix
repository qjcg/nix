{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-python";
  paths = [
    (python39.withPackages (ps:
      with ps; [
        ansible
        beautifulsoup4
        black
        cookiecutter
        ipython
        isort
        jupyter
        matplotlib
        mypy
        numpy
        #poetry
        pandas
        pylint
        requests
        seaborn
      ]))
  ];
  meta = {
    priority = 0;
    description = "An environment for Python development";
  };
}
