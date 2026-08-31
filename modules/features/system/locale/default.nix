{ lib, ... }: {
  den = {
    schema.host.options.locale = {
      timeZone = lib.mkOption {
        type = with lib.types; nullOr str;
        default = null;
        description = "System time zone";
      };
      keyboard = lib.mkOption {
        type = lib.types.str;
        default = "us";
        description = "Keyboard layout";
      };
      default = lib.mkOption {
        type = lib.types.str;
        default = "en_US.UTF-8";
        description = "Default locale";
      };
    };

    aspects.locale = {
      os = { host, ... }: { time.timeZone = host.locale.timeZone; };
      nixos = { host, ... }: with host.locale;
        {
          i18.defaultLocale = default;
          console.keyMap = keyboard;
        };
    };
  };
}
