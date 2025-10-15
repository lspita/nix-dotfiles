{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./vscode.nix {
  config = {
    programs.vscode.enable = true;
  };
}
