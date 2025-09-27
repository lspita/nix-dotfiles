{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./. {
  config =
    let
      configDir = "zed";
    in
    {
      home = {
        # not programs.zed-editor to have the settings symlinked
        packages = with pkgs; [
          zed-editor
        ];
        shellAliases.zed = "zeditor";
      };
      xdg.configFile = {
        "${configDir}/settings.json".source =
          utils.dotSymlink config "modules/home/editor/zed/settings.json";
      };
    };
}
