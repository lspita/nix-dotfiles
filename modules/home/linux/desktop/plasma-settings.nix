{
  config,
  customLib,
  flakeInputs,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "plasmaSettings"
  ];
  imports = [ flakeInputs.plasma-manager.homeModules.plasma-manager ];
  mkConfig =
    { ... }:
    {
      programs.plasma = {
        enable = true;
        workspace = {
          enableMiddleClickPaste = false;
          lookAndFeel = "org.kde.breeze.desktop";
        };
      };
    };
}
