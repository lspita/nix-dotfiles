{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  options = {
    term = lib.mkOption {
      type = with lib.types; str;
      default = "xterm-256color"; # xterm-kitty not good for ssh
      description = "term type to use";
    };
    theme = lib.mkOption {
      type = with lib.types; nullOr str;
      default = "catppuccin";
      description = "kitty theme";
    };
  };
  config =
    { self, ... }:
    {
      programs.kitty = {
        enable = true;
        enableGitIntegration = packages.isInstalled inputs "git";
        font =
          let
            fontZoom = 1.2;
            monospace = vars.fonts.monospace;
          in
          optionals.ifNotNull null {
            inherit (monospace) name;
            size = monospace.size * fontZoom;
          } monospace;
        shellIntegration.mode = "no-cursor";
        settings = {
          term = self.term;
          touch_scroll_multiplier = 2.0;
          # cursor
          cursor_shape = "block";
          cursor_shape_unfocused = "hollow";
          cursor_trail = 10; # ms
        };
      };
      xdg.configFile =
        if isNull self.theme then
          { }
        else
          let
            kittyConfigDir = "kitty";
            theme = ./themes/${self.theme};
            paths =
              if lib.filesystem.pathIsDirectory theme then
                {
                  dark = "${theme}/dark.conf";
                  light = "${theme}/light.conf";
                }
              else
                {
                  dark = "${theme}.conf";
                  light = "${theme}.conf";
                };
          in
          {
            # https://sw.kovidgoyal.net/kitty/kittens/themes/#change-color-themes-automatically-when-the-os-switches-between-light-and-dark
            "${kittyConfigDir}/no-preference-theme.auto.conf".source = paths.dark;
            "${kittyConfigDir}/dark-theme.auto.conf".source = paths.dark;
            "${kittyConfigDir}/light-theme.auto.conf".source = paths.light;
          };
    };
}
