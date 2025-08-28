{
  config,
  customLib,
  lib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "modules"
    "system"
    "nixos"
    "boot"
  ];
  extraOptions = {
    configurationLimit = lib.mkOption {
      type = lib.types.int;
      default = 10;
      description = "Maximum number of latest generations in the boot menu.";
    };
    entriesTimeout = lib.mkOption {
      type = lib.types.int;
      default = 0;
      description = "Timeout (in seconds) until loader boots the default menu item.";
    };
  };
  mkConfig =
    { cfg }:
    {
      boot = {
        loader = {
          systemd-boot = {
            enable = true;
            editor = false; # recommended false https://search.nixos.org/options?channel=unstable&show=boot.loader.systemd-boot.editor
            configurationLimit = cfg.configurationLimit;
          };
          efi.canTouchEfiVariables = true;
          timeout = cfg.entriesTimeout; # spam space to show entries selection
        };
        tmp.cleanOnBoot = true;

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
      };
    };
}
