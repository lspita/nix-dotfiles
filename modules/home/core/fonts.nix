{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./fonts.nix {
  config = with vars.fonts; {
    home.packages = utils.ifNotNull [ ] (packages pkgs) packages;
  };
}
