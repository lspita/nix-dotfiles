{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./layout.nix {
  config =
    let
      defaultAppFolders = [
        "Utilities"
        "System"
      ];
    in
    {
      dconf.settings = {
        "org/gnome/shell" = {
          favorite-apps =
            with vars.linux.defaultApps;
            let
              gnomeApps = gnome.defaults.apps;
            in
            map (app: app.desktop) (
              builtins.filter (app: !(isNull app)) [
                browser
                editor
                (optionals.getNotNull gnomeApps.terminal terminal)
                (optionals.getNotNull gnomeApps.fileManager fileManager)
                music
              ]
            );
        };
      }
      // (
        # empty default gnome app drawer folders
        builtins.foldl' (
          result: folder: result // { "org/gnome/desktop/app-folders/folders/${folder}".apps = [ ]; }
        ) { } defaultAppFolders
      );
    };
}
