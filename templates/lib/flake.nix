{
  description = "A flake providing a library.";

  inputs = { };

  outputs = { self, ... }@inputs: {
    lib = import ./repl.nix { };
  };
}
