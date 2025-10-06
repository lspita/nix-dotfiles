{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./delta.nix {
  config = {
    programs.git.delta.enable = true;
  };
}
