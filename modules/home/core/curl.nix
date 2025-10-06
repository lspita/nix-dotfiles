{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./curl.nix {
  config = {
    home.packages = with pkgs; [ curl ];
  };
}
