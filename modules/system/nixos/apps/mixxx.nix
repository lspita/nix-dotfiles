{
  lib,
  vars,
  pkgs,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./mixxx.nix {
  config = {
    environment.systemPackages = with pkgs; [ mixxx ];
    users.users.${vars.user.username}.extraGroups = [
      # realtime audio access
      "audio"
      "realtime"
    ];
  };
}
