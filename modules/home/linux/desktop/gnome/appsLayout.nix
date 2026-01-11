{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./appsLayout.nix {
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
            (map (app: app.desktop) (
              builtins.filter (app: !(isNull app)) [
                browser
                editor
                (utils.getNotNull gnome.defaults.terminal terminal)
                (utils.getNotNull gnome.defaults.fileManager fileManager)
                music
              ]
            ));
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
