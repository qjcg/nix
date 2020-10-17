{ lib, ... }:

{
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
