{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./lazydocker.nix {
  config = {
    programs.lazydocker.enable = true;
  };
}
