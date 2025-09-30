{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
with lib.custom;
modules.mkModule config ./fonts.nix {
  config = {
    home.packages = vars.fonts.packages pkgs;
  };
}
