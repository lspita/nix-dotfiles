{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./nix-ld.nix {
  options = { };
  config = {
    programs.nix-ld.enable = true;
  };
}
