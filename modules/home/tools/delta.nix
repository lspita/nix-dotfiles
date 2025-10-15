{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./delta.nix {
  config = {
    programs.git.delta.enable = true;
  };
}
