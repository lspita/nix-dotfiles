{
  config,
  customLib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
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
