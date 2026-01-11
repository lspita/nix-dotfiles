{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./aliases.nix {
  config = {
    home.shellAliases = {
      ll = "ls -al";
      la = "ls -a";
      purge-all = "find . -mindepth 1 -maxdepth 1 -print -exec rm -rf '{}' \\;";
      clean-home-backups = "find . -name '*.${vars.backupFileExtension}' -print -exec rm -rf '{}' \\; 2>/dev/null";
      reload-home-profile = "unset __HM_SESS_VARS_SOURCED && source .profile";
    };
  };
}
