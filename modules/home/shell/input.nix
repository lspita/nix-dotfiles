{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./input.nix {
  options = {
    completition.ignoreCase = modules.mkEnableOption true "case-insensitive completition";
  };
  config =
    { self, ... }:
    {
      home.file.".inputrc".text = ''
        ${if self.completition.ignoreCase then "set completion-ignore-case on" else ""}
      '';
    };
}
