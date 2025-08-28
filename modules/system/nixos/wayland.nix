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
    "wayland"
  ];
  mkConfig =
    { ... }:
    {
      # https://nixos.wiki/wiki/Wayland
      programs.xwayland.enable = true;
      environment.sessionVariables.NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
    };
}
