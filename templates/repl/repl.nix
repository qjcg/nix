# A nix file illustrating

{ userNames ? [ "Abe" "Benson" "Charles" ]
, ...
}:

rec {
  # DEBUGGING
  ## Simply type "math" at the repl to display the trace.
  math = (builtins.trace (1 + 1 + 1 * 3) null);

  # FLAKES
  ## Interact with Flakes.
  pkgs-unstable = (builtins.getFlake "github:nixos/nixpkgs/nixpkgs-unstable");
  jg = (builtins.getFlake "github:qjcg/nix-config");

  # CUSTOM FUNCTIONS
  ## Define a function and call it from a map expression.
  ## From the repl, call `:p users` to review the result.
  mkUser = user: { name = "${user}"; age = 42; };
  users = map (u: mkUser u) userNames;

  data = builtins.fromTOML (builtins.readFile ./data.toml);
}
