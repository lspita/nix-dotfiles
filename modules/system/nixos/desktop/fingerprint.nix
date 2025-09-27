{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./fingerprint.nix {
  config = {
    services.fprintd.enable = true;
  };
}
