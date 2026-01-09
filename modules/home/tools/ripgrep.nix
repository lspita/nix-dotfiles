{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./ripgrep.nix {
  config = {
    programs.ripgrep.enable = true;
  };
}
