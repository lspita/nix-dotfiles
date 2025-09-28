{
  config,
  lib,
  vars,
  ...
}:
with lib.custom;
modules.mkModule config ./aliases.nix {
  config = {
    home.shellAliases = {
      ll = "ls -al";
      la = "ls -a";
      purge-all = "find . -mindepth 1 -maxdepth 1 -print -exec rm -rf '{}' \\;";
      clean-home-backups = "find . -name '*.${vars.backupFileExtension}' -print -exec rm -rf '{}' \\;";
    };
  };
}
