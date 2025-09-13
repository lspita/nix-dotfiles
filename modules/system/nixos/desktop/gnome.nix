{
  config,
  customLib,
  pkgs,
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
      environment.gnome.excludePackages = with pkgs; [
        gnome-contacts
        gnome-tour
        geary
        epiphany
      ];
    };
}
