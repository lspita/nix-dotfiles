{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./lazydocker.nix {
  config = {
    programs.lazydocker.enable = true;
  };
}
