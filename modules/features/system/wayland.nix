{
  den.aspects.system.wayland.nixos = {
    # https://nixos.wiki/wiki/Wayland
    programs.xwayland.enable = true;
    environment.sessionVariables = {
      # NIXOS_OZONE_WL = "1"; # makes some apps behave strange
      ELECTRON_OZONE_PLATFORM_HINT = "auto"; # hint electron apps to use wayland
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
