{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./gh.nix {
  config = {
    programs.gh = {
      enable = true;
      extensions = with pkgs; [
        gh-notify
        gh-skyline
      ];
    };
  };
}
