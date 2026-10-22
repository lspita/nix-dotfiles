{ lib2, ... }: {
  den.aspects.programs.unixtools.homeManager = { pkgs, ... }: {
    home.packages = lib2.pkgs.listGroup pkgs.unixtools;
  };
}
