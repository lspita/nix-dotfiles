{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./element.nix {
  config = {
    programs.element.enable = true;
  };
}
