{
  config,
  customLib,
  pkgs,
  lib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "plasma"
    "appearance"
    "koi"
  ];
  extraOptions =
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
      theme = {
        colors = mkLightDarkThemeOption "colors"; # plasma-apply-colorscheme --list-schemes
        cursor = mkLightDarkThemeOption "cursor theme"; # plasma-apply-cursortheme --list-themes
        gtk = mkLightDarkThemeOption "gtk theme"; # ls /var/run/current-system/sw/share/themes
      };
    };
  mkConfig =
    { cfg }:
    let
      koiPackage = pkgs.kdePackages.koi; # theme switcher https://github.com/baduhai/Koi
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
              mkScript cfg.theme.cursor.enable {
                dark = "${cmd} ${cfg.theme.cursor.dark}";
                light = "${cmd} ${cfg.theme.cursor.light}";
              };
          in
          {
            ${koiScriptDark} = {
              text = ''
                #!/usr/bin/env bash
                ${cursorScript.dark}
              '';
              executable = true;
            };
            ${koiScriptLight} = {
              text = ''
                #!/usr/bin/env bash
                ${cursorScript.light}
              '';
              executable = true;
            };
          };
      };
      programs.plasma = {
        configFile = {
          kdeglobals.General = {
            ColorScheme.persistent = true;
            ColorSchemeHash.persistent = true;
          };
          kcminputrc.Mouse.cursorTheme.persistent = true;
          koirc = {
            General = {
              current.persistent = true;
              notify.value = 0; # disabled
              schedule.value = 0; # disabled
              start-hidden.value = 2; # enabled
            };
            # Koi doesn't recognize these themes, if you press "save" in the app preferences
            # it overwrites with defaults. With the "immutable" option enabled for the keys
            # it doesn't recognize them anymore and says you have empty values.
            ColorScheme = {
              enabled.value = cfg.theme.colors.enable;
              dark.value = cfg.theme.colors.dark;
              light.value = cfg.theme.colors.light;
            };
            Script = {
              enabled.value = cfg.theme.cursor.enable;
              dark.value = "${config.xdg.dataHome}/${koiScriptDark}";
              light.value = "${config.xdg.dataHome}/${koiScriptLight}";
            };
            Wallpaper.enabled.value = false;
            GTKTheme = {
              enabled.value = cfg.theme.gtk.enable;
              dark.value = cfg.theme.gtk.dark;
              light.value = cfg.theme.gtk.light;
            };
            PlasmaStyle.enabled.value = false;
            KvantumStyle.enabled.value = false;
            IconTheme.enabled.value = false;
          };
        };
        hotkeys.commands = {
          "koi-toggle-mode" = {
            comment = "Toggle dakr/light mode (Koi)";
            key = "Meta+F5";
            command = "qdbus dev.baduhai.Koi /Koi local.KoiDbusInterface.toggleMode";
          };
        };
      };
    };
}
