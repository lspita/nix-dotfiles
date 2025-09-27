{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./protonpass.nix {
  config = {
    home.packages = with pkgs; [ proton-pass ];
  };
}
