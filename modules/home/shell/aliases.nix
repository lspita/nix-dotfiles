{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./aliases.nix {
  config = {
    home.shellAliases = {
      ll = "ls -al";
      la = "ls -a";
    };
  };
}
