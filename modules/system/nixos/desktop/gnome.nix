{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
with lib.custom;
modules.mkModule config ./gnome.nix {
  options = {
    excludePackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      description = "Gnome packages to exclude";
    };
  };
  config =
    { self, ... }:
    let
      profiles = assets.profiles config;
      userImage = vars.user.image;
    in
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
        ++ self.excludePackages;

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
      # https://discourse.nixos.org/t/setting-the-user-profile-image-under-gnome/36233
      system.activationScripts =
        if builtins.isNull userImage then
          { }
        else
          {
            gnome-set-pfp.text = ''
              cp -f ${profiles.${userImage}} /var/lib/AccountsService/icons/${vars.user.username}
            '';
          };
    };
}
