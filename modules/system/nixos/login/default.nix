{ customLib, config, ... }:
customLib.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "nixos"
    "login"
  ];
  mkConfig =
    { ... }:
    {
      security.pam.services = {
        sudo.fprintAuth = config.services.fprintd.enable;
        login.fprintAuth = config.services.fprintd.enable;
      };
    };
}
