{
  den,
  lib,
  lib2,
  ...
}:
{
  meta.programs.plasma.konsole = {
    exec = "konsole";
    desktop = "org.kde.konsole.desktop";
  };

  den.aspects.desktop.plasma.programs.konsole =
    let
      themesRoot = ./themes;
      colorSchemeFileExt = ".colorscheme";
      colorSchemes =
        lib.filesystem.listFilesRecursive themesRoot
        |> builtins.filter (lib.hasSuffix colorSchemeFileExt)
        |> map (
          p:
          let
            key =
              p # /nix/store/.../themes/foo/bar.colorscheme
              |> lib.path.removePrefix themesRoot # ./foo/bar.colorscheme
              |> lib.removePrefix "./" # foo/bar.colorscheme
              |> lib.removeSuffix colorSchemeFileExt # foo/bar
              |> lib.replaceString "/" "-"; # foo-bar
          in
          lib.nameValuePair key p
        )
        |> lib.listToAttrs;
    in
    {
      includes = with den.aspects.desktop.plasma.programs.konsole; [ theme ];

      color-scheme = name: p: {
        homeManager = { config, host, ... }: {
          programs.konsole = {
            customColorSchemes.${name} = p;
            profiles.${name} =
              let
                plasmaMonospaceFont = config.programs.plasma.fonts.fixedWidth or null;
                monospaceFont =
                  (
                    if isNull plasmaMonospaceFont then
                      lib2.optionals.getOrDefault {
                        name = "monospace";
                        size = 1;
                      } host.fonts.monospace
                    else
                      (
                        plasmaMonospaceFont
                        // {
                          name = plasmaMonospaceFont.family;
                          size = plasmaMonospaceFont.pointSize;
                        }
                      )
                  )
                  |> lib2.fonts.withZoom 1.2
                  |> lib2.fonts.withFlooredSize;
              in
              {
                colorScheme = name;
                font = monospaceFont;
              };
          };
        };
      };

      themes = colorSchemes |> lib.mapAttrs den.aspects.desktop.plasma.programs.konsole.color-scheme;

      theme =
        { host, ... }:
        lib.optionalAttrs (!isNull host.theme) (
          let
            themeAspects = den.aspects.desktop.plasma.programs.konsole.themes;
          in
          {
            includes =
              themeAspects |> lib.filterAttrs (name: _: lib.hasPrefix host.theme name) |> lib.attrValues;

            homeManager.programs.konsole.defaultProfile =
              if themeAspects ? host.theme then host.theme else null;
          }
        );

      homeManager = { pkgs, ... }: {
        home.packages = with pkgs.kdePackages; [ konsole ];

        programs.konsole = {
          enable = true;
          customColorSchemes = colorSchemes;
          extraConfig = {
            Scrolling = {
              ScrollBarPosition = 2;
              HighlightScrolledLines = false;
            };
            "Terminal Features".BlinkingCursorEnabled = true;
          };
        };
      };
    };
}
