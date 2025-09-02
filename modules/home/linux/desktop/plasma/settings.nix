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
    "plasma"
    "settings"
  ];
  imports = [ flakeInputs.plasma-manager.homeModules.plasma-manager ];
  mkConfig =
    { ... }:
    {
      programs.plasma = {
        enable = true;
        workspace = {
          enableMiddleClickPaste = false; # it doesn't disable it in reality :(
        };
      };
    };
}
