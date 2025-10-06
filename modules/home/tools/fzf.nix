{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./fzf.nix {
  config = {
    programs.fzf.enable = true;
  };
}
