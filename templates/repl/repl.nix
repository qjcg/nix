# A nix file illustrating

{ userNames ? [ "Abe" "Benson" "Charles" ]
, ...
}:

rec {
  # Everything under repl attribute for tab-completion discoverability.
  repl = {

    # DEBUGGING
    ## Simply type "math" at the repl to display the trace.
    debugging = {
      math = (builtins.trace (1 + 1 + 1 * 3) null);
    };

    # FLAKES
    ## Interact with Flakes.
    flakes = {
      pkgs = (builtins.getFlake "github:nixos/nixpkgs/nixpkgs-unstable");
      jg = (builtins.getFlake "github:qjcg/nix-config");
      fromFile = (builtins.getFlake (toString ./testdata));
    };

    # CUSTOM FUNCTIONS
    ## Define a function and call it from a map expression.
    ## From the repl, call `:p users` to review the result.
    functions = {
      mkUser = user: { name = "${user}"; age = 42; };
      users = with repl.functions; map (u: mkUser u) userNames;
    };

    # EXTERNAL DATA
    data = {
      toml = builtins.fromTOML (builtins.readFile ./testdata/data.toml);
      json = builtins.fromJSON (builtins.readFile ./testdata/data.json);
      equal = with repl; data.toml == data.json;
    };
  };
}
