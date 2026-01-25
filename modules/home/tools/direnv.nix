{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./direnv.nix {
  options = {
    silent = modules.mkEnableOption false "silent logging";
  };
  config =
    { self, ... }:
    {
      programs.direnv = {
        inherit (self) silent;
        enable = true;
        nix-direnv.enable = true;
        # automatic integration doesn't work
        enableBashIntegration = false;
        enableZshIntegration = false;
        enableNushellIntegration = false;
        enableFishIntegration = false;
      };
      custom.shell.rc = [ (shell: ''eval "$(direnv hook ${shell})"'') ];
    };
}
