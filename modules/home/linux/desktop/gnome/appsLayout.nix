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
            (builtins.filter (app: !(isNull app)) [
              browser.desktop
              editor.desktop
              (utils.getNotNull gnome.defaults.terminal.desktop terminal.desktop)
              (utils.getNotNull gnome.defaults.fileManager.desktop fileManager.desktop)
              music
            ]);
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
