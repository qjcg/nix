{ config, pkgs, ... }:

with pkgs.lib;
let
  # This value corresponds to the user-provided option settings for this module.
  cfg = config.roles.hello;
in
{
  options = {

    # We define a single option controlling whether to enable the "hello" role.
    roles.hello.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the hello role";
    };
  };

  config =
    {
      # If the user of this module has set the option defined above
      # (`roles.hello.enable = true;`), install the hello package.
      environment.systemPackages = mkIf cfg.enable
        (with pkgs; [ hello ]);
    };
}
