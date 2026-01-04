{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./printing.nix {
  config = {
    services.printing.enable = true; # cups
  };
}
