{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./wget.nix {
  config = {
    home.packages = with pkgs; [ wget ];
  };
}
