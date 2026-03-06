{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./android.nix {
  config = platform.systemTypeValue {
    linux = {
      # https://wiki.nixos.org/wiki/Android
      services.udev.packages = with pkgs; [
        platformio-core.udev
        openocd
      ];
      users.users.${vars.user.username}.extraGroups = [ "kvm" ];
    };
    darwin = { };
  };
}
