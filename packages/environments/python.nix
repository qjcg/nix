{ pkgs }:

{
  env-python = pkgs.buildEnv {
    name = "env-python";
    meta.priority = 0;
    paths = with pkgs;
      [
        (python38.withPackages (ps:
          with ps; [
            ansible
            ansible-lint
            beautifulsoup4
            black
            cookiecutter
            ipython
            mypy
            poetry
            pylint
            requests
          ]))
      ];
  };
}
