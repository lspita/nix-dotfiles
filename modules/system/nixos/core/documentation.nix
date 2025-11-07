{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./documentation.nix {
  config = {
    documentation = {
      enable = true;
      man.enable = true;
      dev.enable = true;
    };
  };
}
