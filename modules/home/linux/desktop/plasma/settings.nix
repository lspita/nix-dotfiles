{
  config,
  customLib,
  flakeInputs,
  vars,
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
        overrideConfig = true;
        workspace = {
          enableMiddleClickPaste = false; # it doesn't disable it in reality :(
        };
        input.keyboard.layouts = [
          {
            layout = vars.locale.keyboard;
          }
        ];
      };
    };
}
