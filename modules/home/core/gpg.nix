{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./gpg.nix {
  config = {
    programs.gpg.enable = true;
  };
}
