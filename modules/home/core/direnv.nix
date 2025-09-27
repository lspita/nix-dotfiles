{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./direnv.nix {
  config = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
