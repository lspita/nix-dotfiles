{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./jq.nix {
  config = {
    programs.jq.enable = true;
  };
}
