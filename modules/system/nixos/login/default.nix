{
  customLib,
  config,
  lib,
  ...
}:
customLib.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "nixos"
    "login"
  ];
  mkConfig =
    { ... }:
    with lib;
    {
      security.pam.services = {
        sudo.fprintAuth = mkDefault config.services.fprintd.enable;
        login.fprintAuth = mkDefault false; # require password to activate keyring/wallet
      };
    };
}
