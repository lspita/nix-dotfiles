{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./. {
  options = {
    entriesTimeout = lib.mkOption {
      type = lib.types.int;
      default = 0;
      description = "Timeout (in seconds) until loader boots the default menu item.";
    };
  };
  config =
    { self, ... }:
    {
      boot = {
        loader = {
          systemd-boot = {
            enable = true;
            editor = false; # recommended false https://search.nixos.org/options?channel=unstable&show=boot.loader.systemd-boot.editor
          };
          efi.canTouchEfiVariables = true;
          timeout = self.entriesTimeout; # spam space to show entries selection
        };
        tmp.cleanOnBoot = true;
      };
    };
}
