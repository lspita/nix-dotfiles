{
  den.aspects.boot =
    { config, lib, ... }:
    {
      imports = [
        {
          options = {
            kernel.packages = lib.mkOption {
              type = with lib.types; nullOr raw;
              default = null;
              description = "Linux kernel packages to use.";
            };
            entries = {
              max = lib.mkOption {
                type = lib.types.int;
                default = 10;
                description = "Maximum number of latest generations in the boot menu.";
              };
              timeout = lib.mkOption {
                type = with lib.types; nullOr int;
                default = null;
                description = "Timeout (in seconds) until loader boots the default menu item.";
              };
            };
            tmp.clean = lib.mkOption {
              type = lib.types.bool;
              default = true;
              description = "Whether to enable tmp clean on boot.";
            };
          };
        }
      ];
      nixos = { pkgs, ... }: {
        boot = {
          # https://wiki.nixos.org/wiki/Linux_kernel
          kernelPackages =
            with config.kernel;
            if packages != null then packages else pkgs.linuxPackages_latest;
          loader = {
            inherit (config.entries) timeout;
            systemd-boot = {
              enable = true;
              editor = false; # recommended false
              configurationLimit = config.entries.max;
            };
            efi.canTouchEfiVariables = true;
          };
          tmp.cleanOnBoot = config.tmp.clean;
        };
      };
    };
}
