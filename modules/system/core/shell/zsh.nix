{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./zsh.nix {
  config = {
    programs.zsh.enable = true;
  };
}
