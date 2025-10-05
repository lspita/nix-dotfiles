{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./hoppscotch.nix {
  config = {
    home.packages = with pkgs; [ hoppscotch ];
  };
}
