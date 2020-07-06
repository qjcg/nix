self: super:

{
  env-python = super.pkgs.buildEnv {
    name = "env-python";
    meta.priority = 0;
    paths = with super.pkgs; [
      cookiecutter
      poetry
      python37Packages.black

      (python38.withPackages
        (ps: with ps; [ beautifulsoup4 ipython mypy pylint requests ]))
    ];
  };
}
