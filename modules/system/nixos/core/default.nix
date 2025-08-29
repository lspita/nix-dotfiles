{ customLib, config, ... }:
{
  imports = customLib.scanPaths ./.;
}
// customLib.mkModule {
  inherit config;
  path = [
    "nixos"
    "core"
  ];
  name = "default nixos system modules";
  mkConfig =
    { ... }:
    {
      modules.nixos.core = {
        boot.enable = true;
        wayland.enable = true;
        locale.enable = true;
        services.enable = true;
        user.enable = true;
        audio = {
          pipewire.enable = true;
        };
        network = {
          networkmanager.enable = true;
        };
      };
    };
}
