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
      default = optionals.ifNotNull [ ] (with pkgs; [
        gnome-console
      ]) vars.linux.defaultApps.terminal;
      description = "Gnome packages to exclude";
    };
  };
  config =
    { self, setSubconfig, ... }:
    let
      profiles = assets.profiles inputs;
      userImage = vars.user.image;
    in
    {
      services.desktopManager.gnome.enable = true;
      environment = {
        gnome.excludePackages =
          with pkgs;
          [
            gnome-contacts
            gnome-tour
            geary
            epiphany
            yelp
            gnome-maps
          ]
          ++ self.excludePackages;
        # Fix visual glitches in gtk popup windows
        # https://www.reddit.com/r/Fedora/comments/1oirfcr/comment/nlzxhyq/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        # sessionVariables.GSK_RENDERER = "gl";
      };
      # https://discourse.nixos.org/t/setting-the-user-profile-image-under-gnome/36233
      system.activationScripts =
        if isNull userImage then
          { }
        else
          {
            gnome-set-pfp.text =
              # https://discourse.nixos.org/t/setting-the-user-profile-image-under-gnome/36233/6
              let
                username = vars.user.username;
                imageFile = profiles.${userImage};
                outDir = "/var/lib/AccountsService";
                iconsDir = "${outDir}/icons";
                usersDir = "${outDir}/users";
                iconFile = "${iconsDir}/${username}";
                userFile = "${usersDir}/${username}";
              in
              ''
                rm -rf ${iconFile}
                rm -rf ${userFile}
                mkdir -p ${iconsDir}
                mkdir -p ${usersDir}
                cp -f ${imageFile} ${iconFile}
                echo -e "[User]\nIcon=${imageFile}\n" > ${userFile}
              '';
          };
    }
    // (setSubconfig {
      nautilus.enableDefaults = true;
    });
}
