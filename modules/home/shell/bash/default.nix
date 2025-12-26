{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  options = {
    completition.enable = utils.mkTrueEnableOption "bash completition";
  };
  config =
    { self, setDefaultSubconfig, ... }:
    (setDefaultSubconfig {
      autocd.enable = true;
    })
    // {
      programs.bash = {
        enable = true;
        enableCompletion = self.completition.enable;
        initExtra = lib.mkAfter (shell.loadrc inputs "bash");
      };
    };
}
