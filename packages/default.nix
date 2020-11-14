final: prev:
let
  packages =
    prev.lib.attrsets.genAttrs
      (builtins.attrNames (builtins.readDir ./custom))
      (name: prev.callPackage (./custom + "/${name}") { });

  # TODO: Rewrite as a DRY function.
  environments = {
    env-financial = prev.callPackage ./environments/financial.nix { };
    env-go = prev.callPackage ./environments/go.nix { };
    env-k8s = prev.callPackage ./environments/k8s.nix { };
    env-multimedia = prev.callPackage ./environments/multimedia.nix { };
    env-nix = prev.callPackage ./environments/nix.nix { };
    env-personal = prev.callPackage ./environments/personal.nix { };
    env-python = prev.callPackage ./environments/python.nix { };
    env-ruby = prev.callPackage ./environments/ruby.nix { };
    env-shell = prev.callPackage ./environments/shell.nix { };
    env-tools = prev.callPackage ./environments/tools.nix { };
  };

  # TODO: Rewrite as a DRY function.
  overrides = {
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
