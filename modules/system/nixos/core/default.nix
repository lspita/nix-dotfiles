{ customLib, config, ... }:
customLib.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "nixos"
    "core"
  ];
  mkConfig =
    { ... }:
    {
      custom.modules = {
        nix.enable = true;
        nixos.core = {
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
    };
}
