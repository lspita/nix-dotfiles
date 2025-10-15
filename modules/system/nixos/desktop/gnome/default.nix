{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./. {
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
      profiles = assets.profiles inputs;
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
          gnome-console
        ]
        ++ self.excludePackages;

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
