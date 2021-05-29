{ pkgs }:
let
  inherit (pkgs) buildEnv;
in
buildEnv {
  name = "env-clojure";
  paths = with pkgs; [
    #babashka
    boot
    #clj-kondo
    clojure
    #clojure-lsp
    joker
    leiningen
    lumo
    parinfer-rust

    # FIXME: Uncomment once nixpkgs is updated in parent flake. At the
    # time of writing, this package is not in the version of nixpkgs in
    # use.
    #
    # zprint
  ];
  meta = {
    description = "An environment for Clojure development";
    priority = 0;
  };
}
