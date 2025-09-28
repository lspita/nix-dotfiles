{ lib, root }:
config: program:
let
  packagesLists = [
    # remember to put the "or []", you can't put it in a map function
    (config.home.packages or [ ])
    (config.environment.systemPackages or [ ])
  ];
in
config.programs.${program}.enable or false
|| lib.any (p: (lib.getName p) == program) (lib.lists.flatten packagesLists)
