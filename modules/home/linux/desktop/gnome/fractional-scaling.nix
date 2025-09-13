{
  config,
  customLib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "gnome"
    "fractionalScaling"
  ];
  mkConfig =
    { ... }:
    {
      dconf.settings."org/gnome/mutter".experimental-features = [
        "scale-monitor-framebuffer"
        "xwayland-native-scaling"
      ];
    };
}
