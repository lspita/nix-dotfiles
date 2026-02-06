{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./sddm.nix {
  options = {
    wayland.enable = modules.mkEnableOption true "wayland support";
  };
  config =
    { self, ... }:
    {
      # https://wiki.nixos.org/wiki/KDE
      services.displayManager.sddm = {
        enable = true;

        # To use Wayland (Experimental for SDDM)
        wayland = {
          inherit (self.wayland) enable;
          compositor = "kwin";
        };
        autoNumlock = true;
      };
      security.pam.services.login.fprintAuth = lib.mkForce false; # fix sddm waiting for fingerprint
    };
}
