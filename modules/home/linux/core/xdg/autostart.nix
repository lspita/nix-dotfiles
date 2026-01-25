{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./autostart.nix {
  config = {
    xdg.autostart.enable = true;
  };
}
