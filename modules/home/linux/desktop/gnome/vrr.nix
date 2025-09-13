{
  config,
  customLib,
  lib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "gnome"
    "vrr"
  ];
  mkConfig =
    { ... }:
    {
      dconf.settings."org/gnome/mutter".experimental-features = [ "variable-refresh-rate" ];
    };
}
