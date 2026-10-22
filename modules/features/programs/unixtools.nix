{ lib2, ... }: {
  den.aspects.programs.unixtools.nixos = { pkgs, ... }: {
    environment.systemPackages = lib2.pkgs.listGroup pkgs.unixtools;
  };
}
