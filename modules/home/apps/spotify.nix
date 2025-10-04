{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./spotify.nix {
  config = {
    home.packages = with pkgs; [ spotify ];
  };
}
