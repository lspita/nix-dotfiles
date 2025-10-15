{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./lazygit.nix {
  config = {
    programs.lazygit.enable = true;
  };
}
