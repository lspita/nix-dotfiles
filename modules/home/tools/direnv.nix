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
      };
      custom.shell.rc = [ (shell: ''eval "$(direnv hook ${shell})"'') ];
    };
}
