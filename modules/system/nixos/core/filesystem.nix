{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./filesystem.nix {
  config = {
    environment.systemPackages = with pkgs; [
      # exfat support
      exfat
      exfatprogs
    ];
  };
}
