{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./wayland.nix {
  config = {
    # https://nixos.wiki/wiki/Wayland
    programs.xwayland.enable = true;
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
      ELECTRON_OZONE_PLATFORM_HINT = "auto"; # hint electron apps to use wayland
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
