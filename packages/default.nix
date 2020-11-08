final: prev:
let
  packages =
    prev.lib.attrsets.genAttrs
      (builtins.attrNames (builtins.readDir ./custom))
      (name: prev.callPackage (./custom + "/${name}") { });

  # TODO: Rewrite as a DRY function.
  environments = {
    env-financial = import ./environments/financial.nix final prev;
    env-go = import ./environments/go.nix final prev;
    env-k8s = import ./environments/k8s.nix final prev;
    env-multimedia = import ./environments/multimedia.nix final prev;
    env-neovim = import ./environments/neovim.nix final prev;
    env-nix = import ./environments/nix.nix final prev;
    env-personal = import ./environments/personal.nix final prev;
    env-python = import ./environments/python.nix final prev;
    env-ruby = import ./environments/ruby.nix final prev;
    env-shell = import ./environments/shell.nix final prev;
    env-tools = import ./environments/tools.nix final prev;
  };

  # TODO: Rewrite as a DRY function.
  # TODO: Reorganize files (each package in a separate dir, for ease of DRY rewriting?)
  overrides = {
    delve = import ./overrides/delve.nix final prev;
    dunst = import ./overrides/dunst.nix final prev;
    emacs = import ./overrides/emacs.nix final prev;
    neovim = import ./overrides/neovim final prev;
    retroarch = import ./overrides/retroarch.nix final prev;
    st = import ./overrides/st final prev;
    sxiv = import ./overrides/sxiv final prev;
    vscodium-with-extensions = import ./overrides/vscodium-with-extensions.nix final prev;
    #wayfire = import ./overrides/wayfire final prev;
  };
in
packages // environments // overrides
