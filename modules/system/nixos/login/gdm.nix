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
    "gdm"
  ];
  mkConfig =
    { ... }:
    {
      services.displayManager.gdm = {
        enable = true;
        wayland = config.modules.nixos.core.wayland.enable;
      };
      security.pam.services.gdm = {
        fprintAuth = config.services.fprintd.enable;
        enableGnomeKeyring = true; # not working when using fingerprint https://gitlab.gnome.org/GNOME/gdm/-/issues/613
      };
    };
}
