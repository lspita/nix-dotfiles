{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./ssh.nix {
  config = {
    services.openssh.enable = true;
  };
}
