{ pkgs }:

let
  inherit (pkgs) buildEnv;
  inherit (pkgs.stdenv) isDarwin isLinux;
  inherit (pkgs.lib.lists) optionals;
in

buildEnv {
  name = "env-emacs";
  paths = with pkgs; [
    jg.overrides.emacs

    graphviz
    nodePackages.mermaid-cli
    nodePackages.prettier
    nodePackages.vega-cli
    nodePackages.vega-lite
    plantuml
    tectonic
  ] ++ optionals isLinux [
  ] ++ optionals isDarwin [
  ];

  meta = {
    priority = 0;
    description = "An environment providing emacs and dependencies required for various features and modes";
  };
}
