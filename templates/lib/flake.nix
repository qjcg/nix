{
  description = "A flake providing a Nix library.";

  inputs = { };

  outputs = { self, ... }@inputs: {
    lib = import ./lib { };
  };
}
