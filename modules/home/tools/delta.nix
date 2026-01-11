{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./delta.nix {
  options = {
    git.enable = utils.mkEnableOption true "git integration";
  };
  config =
    { self, ... }:
    {
      programs.delta = {
        enable = true;
        enableGitIntegration = self.git.enable;
      };
    };
}
