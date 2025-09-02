{
  config,
  customLib,
  lib,
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
      custom.modules.nixos.login.enableDefaults = true;
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = config.custom.modules.nixos.core.wayland.enable;
      };
      security.pam.services.login.fprintAuth = lib.mkForce false; # fix sddm waiting for fingerprint
    };
}
