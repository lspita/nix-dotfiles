{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./obsidian.nix {
  config = {
    programs.obsidian.enable = true;
  };
}
