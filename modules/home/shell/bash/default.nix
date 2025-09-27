{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./. {
  config = {
    programs.bash = {
      enable = true;
      enableCompletion = true;
    };
  };
}
