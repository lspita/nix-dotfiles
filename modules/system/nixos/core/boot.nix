{
  config,
  lib,
  vars,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "nixos"
    "core"
    "boot"
  ];
  extraOptions = {
    entriesTimeout = lib.mkOption {
      type = lib.types.int;
      default = 0;
      description = "Timeout (in seconds) until loader boots the default menu item.";
    };
    plymouth.enable = lib.custom.mkTrueEnableOption "plymouth boot screen";
  };
  mkConfig =
    { cfg }:
    {
      boot = {
        loader = {
          systemd-boot = {
            enable = true;
            editor = false; # recommended false https://search.nixos.org/options?channel=unstable&show=boot.loader.systemd-boot.editor
            configurationLimit = vars.nix.cleaning.maxGenerations;
          };
          efi.canTouchEfiVariables = true;
          timeout = cfg.entriesTimeout; # spam space to show entries selection
        };
        tmp.cleanOnBoot = true;
      }
      // (
        # lib.mkIf gives an error like no options at all where set in boot
        if cfg.plymouth.enable then
          {
            # https://wiki.nixos.org/wiki/Plymouth
            plymouth = {
              enable = true;
              theme = "bgrt"; # distro logo
            };

            # Enable "Silent boot"
            consoleLogLevel = 3;
            initrd.verbose = false;
            kernelParams = [
              "quiet"
              "splash"
              "boot.shell_on_fail"
              "udev.log_priority=3"
              "rd.systemd.show_status=auto"
            ];
          }
        else
          { }
      );
    };
}
