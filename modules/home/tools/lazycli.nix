{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./lazycli.nix {
  config = {
    home.packages = with pkgs; [ lazycli ];
  };
}
