{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./home-manager.nix {
  options = {
    functions.enable = modules.mkEnableOption true "shell functions";
  };
  config =
    { self, ... }:
    {
      programs.home-manager.enable = true;
      custom.shell.rc = lib.lists.optionals self.functions.enable [
        ''
          clean-home-backups() {
            local dir=''${1:-"."}
            find $dir -name '*.${vars.backupFileExtension}' -print -exec rm -rf '{}' \\; 2>/dev/null
          }
        ''
        ''
          reload-home-profile() {
            unset __HM_SESS_VARS_SOURCED && source ~/.profile
          }
        ''
      ];
    };
}
