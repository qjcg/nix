{ config, pkgs, ... }:

{
  config = {
    system.defaults.NSGlobalDomain.InitialKeyRepeat = null; # This sets how long you must hold down the key before it starts repeating.
    system.defaults.NSGlobalDomain.KeyRepeat = 0; # Sets how fast keys repeat once repeating has started.
  };
}
