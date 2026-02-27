{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./aliases.nix {
  config = {
    home.shellAliases = {
      ll = "ls -al";
      la = "ls -a";
      purge-all = "find . -mindepth 1 -maxdepth 1 -print -exec rm -rf '{}' \\;";
    };
  };
}
