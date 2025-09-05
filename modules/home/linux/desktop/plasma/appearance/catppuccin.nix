{
  config,
  customLib,
  pkgs,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "plasma"
    "appearance"
    "catppuccin"
  ];
  mkConfig =
    { ... }:
    let
      koiPackage = pkgs.kdePackages.koi; # theme switcher https://github.com/baduhai/Koi
      koiScriptsDataDir = "koi/scripts";
      koiScriptDark = "${koiScriptsDataDir}/dark.sh";
      koiScriptLight = "${koiScriptsDataDir}/light.sh";
    in
    {
      home.packages = with pkgs; [
        koiPackage
        (catppuccin-kde.override {
          flavour = [
            "mocha"
            "latte"
          ];
          accents = [ "sapphire" ];
          winDecStyles = [ "classic" ];
        })
        catppuccin-cursors.mochaLight
        catppuccin-cursors.latteDark
      ];
      xdg = {
        autostart.entries = [ "${koiPackage}/share/applications/local.KoiDbusInterface.desktop" ];
        dataFile = {
          ${koiScriptDark} = {
            text = ''
              #!/usr/bin/env bash
              plasma-apply-cursortheme catppuccin-mocha-light-cursors
            '';
            executable = true;
          };
          ${koiScriptLight} = {
            text = ''
              #!/usr/bin/env bash
              plasma-apply-cursortheme catppuccin-latte-dark-cursors
            '';
            executable = true;
          };
        };
      };
      programs.plasma = {
        workspace = {
          # Breeze (default, that is breeze) follows colors
          theme = "default";
          splashScreen.theme = "None";
        };
        configFile = {
          kdeglobals.General.ColorScheme.persistent = true;
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
              # see available with plasma-apply-colorscheme -l
              enabled.value = true;
              dark.value = "CatppuccinMochaSapphire";
              light.value = "CatppuccinLatteSapphire";
            };
            Script = {
              enabled.value = true;
              dark.value = "${config.xdg.dataHome}/${koiScriptDark}";
              light.value = "${config.xdg.dataHome}/${koiScriptLight}";
            };
            Wallpaper.enabled.value = false;
            GTKTheme.enabled.value = false;
            PlasmaStyle.enabled.value = false;
            KvantumStyle.enabled.value = false;
            IconTheme.enabled.value = false;
          };
        };
        hotkeys.commands = {
          "koi-toggle-theme" = {
            key = "Meta+F5";
            command = "qdbus dev.baduhai.Koi /Koi local.KoiDbusInterface.toggleMode";
          };
        };
      };
    };
}
