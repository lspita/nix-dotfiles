{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./nh.nix {
  config = {
    programs.nh = {
      enable = true;
      flake = path.dotRoot config;
    };
  };
}
