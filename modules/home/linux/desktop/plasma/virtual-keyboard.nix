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
    "virtualKeyboard"
  ];
  mkConfig =
    { ... }:
    {
      home.packages = [ pkgs.maliit-keyboard ];
      programs.plasma.configFile.kwinrc = {
        Wayland = {
          InputMethod = {
            value = "${config.home.profileDirectory}/share/applications/com.github.maliit.keyboard.desktop";
            shellExpand = true; # enabling it from the gui settings puts $e
          };
          VirtualKeyboardEnabled.value = true;
        };
      };
    };
}
