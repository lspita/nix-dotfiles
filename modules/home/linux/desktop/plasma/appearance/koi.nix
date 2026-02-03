{
  config,
  lib,
  pkgs,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./koi.nix {
  options =
    let
      mkThemeOption =
        description:
        lib.mkOption {
          inherit description;
          type = lib.types.nullOr lib.types.str;
          default = null;
        };
      mkLightDarkThemeOption = description: {
        enable = lib.mkEnableOption description;
        light = mkThemeOption "${description} (light)";
        dark = mkThemeOption "${description} (dark)";
      };
    in
    {
      themes = {
        colors = mkLightDarkThemeOption "colors"; # plasma-apply-colorscheme --list-schemes
        cursor = mkLightDarkThemeOption "cursor theme"; # plasma-apply-cursortheme --list-themes
        gtk = mkLightDarkThemeOption "gtk theme"; # ls /var/run/current-system/sw/share/themes
        konsole = mkLightDarkThemeOption "konsole profile"; # ls ~/.local/share/konsole
      };
      toggle.shortcut = lib.mkOption {
        type = with lib.types; nullOr str;
        default = null;
        description = "Shortcut to toggle between light and dark mode";
      };
    };
  config =
    { self, ... }:
    # https://github.com/baduhai/Koi
    let
      koiPackage = pkgs.kdePackages.koi;
      koiScriptsDataDir = "koi/scripts";
      koiScriptDark = "${koiScriptsDataDir}/dark.sh";
      koiScriptLight = "${koiScriptsDataDir}/light.sh";
    in
    {
      home.packages = [ koiPackage ];
      xdg = {
        autostart.entries = [ "${koiPackage}/share/applications/local.KoiDbusInterface.desktop" ];
        dataFile =
          let
            mkScript =
              enable:
              { dark, light }:
              if enable then
                { inherit dark light; }
              else
                {
                  dark = "";
                  light = "";
                };
            cursorScript =
              let
                cmd = "plasma-apply-cursortheme";
              in
              with self.themes.cursor;
              mkScript enable {
                dark = "${cmd} ${dark}";
                light = "${cmd} ${light}";
              };
          in
          {
            ${koiScriptDark} = {
              text = ''
                #!/bin/sh
                ${cursorScript.dark}
              '';
              executable = true;
            };
            ${koiScriptLight} = {
              text = ''
                #!/bin/sh
                ${cursorScript.light}
              '';
              executable = true;
            };
          };
      };
      programs.plasma = {
        configFile = {
          kdeglobals.General.ColorScheme.persistent = true;
          kcminputrc.Mouse.cursorTheme.persistent = true;
          koirc = {
            # https://github.com/baduhai/Koi/blob/master/Development/Configuration/Samples/koirc.sample
            General = {
              current.persistent = true;
              latitude.persistent = true;
              longitude.persistent = true;
              notify.value = 0; # disabled
              schedule.value = 0; # disabled
              start-hidden.value = 2; # enabled
            };
            # Koi doesn't recognize these themes, if you press "save" in the app preferences
            # it overwrites with defaults. With the "immutable" option enabled for the keys
            # it doesn't recognize them anymore and says you have empty values.
            ColorScheme = with self.themes.colors; {
              enabled.value = enable;
              dark.value = dark;
              light.value = light;
            };
            Script = {
              enabled.value = self.themes.cursor.enable;
              dark.value = "${config.xdg.dataHome}/${koiScriptDark}";
              light.value = "${config.xdg.dataHome}/${koiScriptLight}";
            };
            Wallpaper.enabled.value = false;
            GTKTheme = with self.themes.gtk; {
              enabled.value = enable;
              dark.value = dark;
              light.value = light;
            };
            KonsoleProfile = with self.themes.konsole; {
              enabled.value = enable;
              dark.value = dark;
              light.value = light;
            };
            PlasmaStyle.enabled.value = false;
            KvantumStyle.enabled.value = false;
            IconTheme.enabled.value = false;
          };
        };
      }
      // (optionals.ifNotNull { } {
        hotkeys.commands = {
          "koi-toggle-mode" = {
            comment = "Toggle dakr/light mode (Koi)";
            key = self.toggle.shortcut;
            command = "qdbus dev.baduhai.Koi /Koi local.KoiDbusInterface.toggleMode";
          };
        };
      } self.toggle.shortcut);
    };
}
