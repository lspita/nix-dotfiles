{
  config,
  customLib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "modules"
    "system"
    "nixos"
    "desktop"
    "gnome"
  ];
  mkConfig =
    { ... }:
    {
      services.desktopManager.gnome.enable = true;
    };
}
