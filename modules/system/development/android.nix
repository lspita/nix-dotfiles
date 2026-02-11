{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./android.nix {
  config = lib.mkMerge [
    {
      # https://nixos.wiki/wiki/Android
      # https://wiki.nixos.org/wiki/Android#Android_Studio
      environment.systemPackages = with pkgs; [ android-tools ];
      users.users.${vars.user.username}.extraGroups = [ "adbusers" ];
      nixpkgs.config.android_sdk.accept_license = true;
    }
    (platform.systemTypeValue {
      linux = {
        services.udev.packages = with pkgs; [
          android-udev-rules
        ];
      };
      wsl = { };
      darwin = { };
    })
  ];
}
