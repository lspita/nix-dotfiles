{
  config,
  customLib,
  pkgs,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "editor"
    "zed"
  ];
  mkConfig =
    { ... }:
    let
      configDir = "zed";
    in
    {
      # not programs.zed-editor to have the settings symlinked
      home.packages = with pkgs; [
        zed-editor
      ];
      xdg.configFile = {
        "${configDir}/settings.json".source = config.lib.file.mkOutOfStoreSymlink (
          customLib.dotPath config "modules/home/editor/zed/settings.json"
        );
      };
    };
}
