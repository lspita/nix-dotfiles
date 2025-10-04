{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./nixld.nix {
  config = {
    programs.nix-ld.enable = true;
  };
}
