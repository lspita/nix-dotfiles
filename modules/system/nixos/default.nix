{ customLib, config, ... }:
{
  imports = customLib.scanPaths ./.;
}
// customLib.mkModule {
  inherit config;
  path = [
    "nixos"
  ];
  enableOption = "defaultModules";
  name = "default nixos system modules";
  mkConfig =
    { ... }:
    {
      modules.nixos = {
        boot.enable = true;
        wayland.enable = true;
        locale.enable = true;
        services.enable = true;
        user.enable = true;
      };
    };
}
