{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "nixos"
    "desktop"
    "gnome"
  ];
  extraOptions = {
    excludePackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      description = "Gnome packages to exclude";
    };
  };
  mkConfig =
    { cfg }:
    {
      services.desktopManager.gnome.enable = true;
      environment.gnome.excludePackages =
        with pkgs;
        [
          gnome-contacts
          gnome-tour
          geary
          epiphany
        ]
        ++ cfg.excludePackages;

      # https://github.com/Stunkymonkey/nautilus-open-any-terminal
      programs = {
        nautilus-open-any-terminal = {
          enable = true;
          terminal = "custom";
        };
        dconf.profiles.user.databases = [
          {
            settings."com/github/stunkymonkey/nautilus-open-any-terminal" = {
              # https://github.com/Stunkymonkey/nautilus-open-any-terminal/blob/253fb95c649ab05641cf7e6b5090a2146b0b1d6c/nautilus_open_any_terminal/schemas/com.github.stunkymonkey.nautilus-open-any-terminal.gschema.xml#L24-L39
              custom-local-command = "${vars.linux.defaultApps.terminal.program} %s";
              custom-remote-command = "${vars.linux.defaultApps.terminal.program} %s";
            };
          }
        ];
      };
    };
}
