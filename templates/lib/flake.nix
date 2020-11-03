{
  description = "A flake providing a NixOS module.";

  inputs = { };

  outputs = { self, ... }@inputs: {
    nixosModules = {
      fooModule = import ./modules { };
    };
  };
}
