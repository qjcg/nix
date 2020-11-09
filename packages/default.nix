final: prev:
let
  packages =
    prev.lib.attrsets.genAttrs
      (builtins.attrNames (builtins.readDir ./custom))
      (name: prev.callPackage (./custom + "/${name}") { });

  # TODO: Rewrite as a DRY function.
  environments = {
    env-financial = prev.callPackage ./environments/financial.nix { };

    env-go = import ./environments/go.nix final prev;
    env-k8s = import ./environments/k8s.nix final prev;
    env-multimedia = import ./environments/multimedia.nix final prev;
    env-nix = import ./environments/nix.nix final prev;
    env-personal = import ./environments/personal.nix final prev;
    env-python = import ./environments/python.nix final prev;
    env-ruby = import ./environments/ruby.nix final prev;
    env-shell = import ./environments/shell.nix final prev;
    env-tools = import ./environments/tools.nix final prev;
  };

  # TODO: Rewrite as a DRY function.
  overrides = {
    delve = prev.callPackage ./overrides/delve { };
    dunst = prev.callPackage ./overrides/dunst { };
    emacs = prev.callPackage ./overrides/emacs { };
    neovim = prev.callPackage ./overrides/neovim { };
    retroarch = prev.callPackage ./overrides/retroarch { };
    st = prev.callPackage ./overrides/st { };
    sxiv = prev.callPackage ./overrides/sxiv { };
    vscodium-with-extensions = prev.callPackage ./overrides/vscodium-with-extensions { };
    wayfire = prev.callPackage ./overrides/wayfire { };
  };
in
packages // environments // overrides
