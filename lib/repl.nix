let
  inherit (builtins) getFlake match trace;
  inherit (pkgs.lib) filterAttrs;

  # This repo's main flake.
  thisFlake = getFlake (toString ../.);

  # Demonstrate adding this flake's top-level "overlay" to upstream nixpkgs via flake import.
  pkgs = import thisFlake.inputs.nixpkgs {
    overlays = [
      thisFlake.inputs.devshell.overlay
      thisFlake.inputs.emacs.overlay
      thisFlake.inputs.wayland.overlay
      thisFlake.overlay
    ];
  };
in
{
  # Use the "repl" attrset for easy discoverability via tab-completion.
  repl = {
    inherit pkgs;

    flake = thisFlake;

    README = trace ''


      # ABOUT

      This file is for debugging and troubleshooting this repo's nix
      expressions.  It contains a top-level "repl" attrset for easy
      discoverability via tab-completion.


      ## REPL ATTRIBUTES

      - README: This attribute. Describes usage. (To reload, do `:r ; repl.README`).
      - pkgs: imports this flake's inputs.nixpkgs with all overlays.


      ## USAGE EXAMPLES
    ''
      true;

  };
}
