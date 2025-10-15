{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./fonts.nix {
  config = {
    home.packages = vars.fonts.packages pkgs;
  };
}
