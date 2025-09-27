{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./printing.nix {
  config = {
    services.printing.enable = true; # cups
  };
}
