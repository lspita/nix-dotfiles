{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./fd.nix {
  options = {
    hidden = utils.mkTrueEnableOption "hidden flag by default";
    ignores = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ ".git/" ];
      description = "List of file patterns to ignore";
    };
  };
  config =
    { self, ... }:
    {
      programs.fd = {
        inherit (self) hidden ignores;
        enable = true;
      };
    };
}
