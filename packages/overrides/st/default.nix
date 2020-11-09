{ pkgs, ... }:

pkgs.st.override {
  conf = builtins.readFile ./st-config.h;
}
