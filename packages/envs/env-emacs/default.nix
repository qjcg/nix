{ pkgs }:

let
  inherit (pkgs) buildEnv graphviz jre;
  inherit (pkgs.stdenv) isAarch64 isDarwin isLinux;
  inherit (pkgs.lib.lists) optionals;

  # A headless version of plantuml to avoid the useless GUI stealing
  # focus on each invocation (macOS). To achieve this, we add
  # `-Djava.awt.headless=true` to the wrapped command's flags.
  plantumlHeadless = pkgs.plantuml.overrideAttrs
    (old: rec {
      buildCommand = ''
        install -Dm644 $src $out/lib/plantuml.jar
       
        mkdir -p $out/bin
        makeWrapper ${jre}/bin/java $out/bin/plantuml \
          --argv0 plantuml \
          --set GRAPHVIZ_DOT ${graphviz}/bin/dot \
          --add-flags "-Djava.awt.headless=true -jar $out/lib/plantuml.jar"
       
        $out/bin/plantuml -help
      '';
    });
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
    python39Packages.black
    python39Packages.isort
    ripgrep
    tectonic
  ] ++ optionals (!isAarch64) [
    plantumlHeadless # Unsupported on aarch64.
  ];

  meta = {
    priority = 0;
    description = "An environment providing emacs and dependencies required for various features and modes";
  };
}
