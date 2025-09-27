{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./chrome.nix {
  config = {
    home.packages = with pkgs; [ google-chrome ];
  };
}
