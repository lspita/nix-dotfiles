{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./autocd.nix {
  config = {
    custom.shell.rc = [ "shopt -s autocd " ];
  };
}
