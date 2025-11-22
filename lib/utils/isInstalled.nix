{ super, lib }:
# bool: if `program` is installed in any way
{ config, ... }@inputs: # set: config inputs
program: # string: program name
let
  packagesLists = super.configTypeValue inputs {
    home = config.home.packages;
    system = config.environment.systemPackages;
  };
in
config.programs.${program}.enable or false
|| lib.any (p: (lib.getName p) == program) (lib.lists.flatten packagesLists)
