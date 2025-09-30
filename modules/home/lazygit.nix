{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./lazygit.nix {
  config = {
    programs.lazygit.enable = true;
  };
}
