{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./gh.nix {
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
