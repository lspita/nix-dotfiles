{
  config,
  customLib,
  vars,
  pkgs,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "plasma"
    "virtualKeyboard"
  ];
  mkConfig =
    { ... }:
    let
      package = pkgs.maliit-keyboard;
    in
    {
      home.packages = [ package ];
      programs.plasma.configFile.kwinrc = {
        Wayland = {
          InputMethod = {
            value = "${package}/share/applications/com.github.maliit.keyboard.desktop";
            shellExpand = true; # enabling it from the gui settings puts $e
          };
          VirtualKeyboardEnabled.value = true;
        };
      };
    };
}
