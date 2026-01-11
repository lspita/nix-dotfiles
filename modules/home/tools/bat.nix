{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./bat.nix {
  options = {
    extraPackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = with pkgs.bat-extras; [ core ];
      description = "bat extra packages to install";
    };
    fzfPager = {
      enable = utils.mkEnableOption true "bat as the fzf pager";
      range = lib.mkOption {
        type = with lib.types; int;
        default = 500;
        description = "bat fzf pager line range";
      };
    };
    theme = lib.mkOption {
      type = with lib.types; str;
      default = "ansi";
      description = "bat theme name";
    };
  };
  config =
    { self, ... }:
    {
      programs =
        lib.attrsets.recursiveUpdate
          {
            bat = {
              inherit (self) extraPackages;
              enable = true;
              config = {
                inherit (self) theme;
              };
            };
          }
          (
            # https://github.com/sharkdp/bat?tab=readme-ov-file#fzf
            with self.fzfPager;
            if enable then
              {
                fzf.fileWidgetOptions = [
                  "--preview 'bat --color=always --style=numbers --line-range=:${toString range} {}'"
                ];
              }
            else
              { }
          );
    };
}
