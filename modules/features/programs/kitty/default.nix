{
  den,
  lib,
  lib2,
  ...
}:
{
  programs.kitty.exec = "kitty";

  den.aspects.programs.kitty =
    let
      kittyConfigDir = "kitty";
    in
    {
      includes = with den.aspects.programs.kitty; [
        xterm
        theme
      ];

      homeManager = { config, host, ... }: {
        programs.kitty = {
          enable = true;
          enableGitIntegration = lib2.pkgs.isInstalled config "git";
          font =
            let
              fontZoom = 1.2;
              monospace = host.fonts.monospace;
            in
            lib2.optionals.fmapNull (f: {
              inherit (f) name;
              size = f.size * fontZoom;
            }) monospace;
          shellIntegration.mode = "no-cursor";
          settings = {
            touch_scroll_multiplier = 2.0;
            open_url_with = "default";
            cursor_shape = "block";
            cursor_shape_unfocused = "hollow";
            cursor_trail = 0; # ms
          };
        };
      };

      xterm.homeManager.programs.kitty.settings = {
        term = "xterm-256color";
      };

      themes =
        let
          themesDir = ./themes;
        in
        builtins.readDir themesDir
        |> lib.filterAttrs (p: type: type == "directory" || lib.hasSuffix ".conf" p)
        |> builtins.attrNames
        |> builtins.foldl' (
          res: themePath:
          let
            theme = "${themesDir}/${themePath}";
            themeId = lib.removeSuffix ".conf" themePath;
            paths =
              if lib.filesystem.pathIsDirectory theme then
                {
                  dark = "${theme}/dark.conf";
                  light = "${theme}/light.conf";
                }
              else
                {
                  dark = theme;
                  light = theme;
                };
          in
          res
          // {
            ${themeId}.homeManager.xdg.configFile = {
              # https://sw.kovidgoyal.net/kitty/kittens/themes/#change-color-themes-automatically-when-the-os-switches-between-light-and-dark
              "${kittyConfigDir}/no-preference-theme.auto.conf".source = paths.dark;
              "${kittyConfigDir}/dark-theme.auto.conf".source = paths.dark;
              "${kittyConfigDir}/light-theme.auto.conf".source = paths.light;
            };
          }
        ) { };

      theme = { host, ... }: den.aspects.programs.kitty.themes.${host.theme} or { };
    };
}
