{
  config,
  lib,
  ...
}:
with lib.custom;
modules.mkModule config ./fastfetch.nix {
  options = {
    neofetchAlias = utils.mkTrueEnableOption "neofetch alias";
  };
  config =
    { self, ... }:
    {
      programs.fastfetch = {
        enable = true;
      };
      home.shellAliases = if self.neofetchAlias then { neofetch = "fastfetch"; } else { };
    };
}
