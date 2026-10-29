{ den, lib, lib2, ... }:
{
  den.aspects.login.sddm = {
    includes = with den.aspects.login.sddm; [
      wayland
      theme
    ];

    nixos = {
      # https://wiki.nixos.org/wiki/KDE
      services.displayManager.sddm = {
        enable = true;
        autoNumlock = true;
      };
      security.pam.services.login.fprintAuth = lib.mkForce false; # fix sddm waiting for fingerprint
    };

    wayland.nixos =
      { host, ... }:
      lib.optionalAttrs (host.hasAspect den.aspects.system.wayland) {
        services.displayManager.sddm.wayland = {
          enable = true;
          compositor = "kwin";
        };
      };

    theme = { host, ... }: lib2.themes.mkThemeAspect host den.aspects.login.sddm.themes;
  };
}
