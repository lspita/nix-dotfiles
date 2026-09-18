{ lib, ... }: {
  flake.lib.pkgs = {
    isInstalled =
      config: program:
      let
        packagesLists = if config ? home then config.home.packages else config.environment.systemPackages;
      in
      config.programs.${program}.enable or false
      || lib.any (p: (lib.getName p) == program) (lib.lists.flatten packagesLists);
  };
}
