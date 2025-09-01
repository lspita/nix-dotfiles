{
  config,
  customLib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "nixos"
    "login"
    "sddm"
  ];
  mkConfig =
    { ... }:
    {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = config.modules.nixos.core.wayland.enable;
      };
    };
}
