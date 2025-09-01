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
    "plasma"
  ];
  mkConfig =
    { ... }:
    {
      services.desktopManager.plasma6.enable = true;
    };
}
