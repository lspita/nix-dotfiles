{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./onlyoffice.nix {
  config = {
    programs.onlyoffice.enable = true;
  };
}
