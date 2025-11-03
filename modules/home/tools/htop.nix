{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./htop.nix {
  config = {
    programs.htop.enable = true;
  };
}
