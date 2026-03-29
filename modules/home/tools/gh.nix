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
      settings = {
        # https://cli.github.com/manual/gh_config
        git_protocol = "ssh";
      };
    };
  };
}
