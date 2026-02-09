{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./user.nix {
  config =
    with vars.user;
    lib.mkMerge [
      {
        users.users.${username} = {
          description = fullname;
        }
        // (optionals.ifNotNull { } { shell = shell pkgs; } shell)
        // (platform.systemTypeValue {
          linux = {
            isNormalUser = true;
            extraGroups = [
              "wheel"
            ];
          };
          darwin = { };
        });
      }
      (
        let
          profiles = assets.profiles inputs;
          userImage = vars.user.image;
        in
        lib.mkIf (!isNull userImage) (
          platform.systemTypeValue {
            # https://discourse.nixos.org/t/setting-the-user-profile-image-under-gnome/36233
            linux.system.activationScripts.gnome-set-pfp.text =
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
            darwin = { };
          }
        )
      )
    ];
}
