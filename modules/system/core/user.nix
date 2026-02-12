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
          let
            userProfile = profiles.${userImage};
          in
          platform.systemTypeValue {
            # Like this it works on gnome but also other DE (e.g. Plasma)
            # https://discourse.nixos.org/t/setting-the-user-profile-image-under-gnome/36233
            linux = {
              systemd.tmpfiles.rules =
                # https://discourse.nixos.org/t/setting-the-user-profile-image-under-gnome/36233/6
                let
                  username = vars.user.username;
                  imageFile = assets.assetTypeValue userProfile {
                    light-dark = throw "Invalid asset type";
                    regular = userProfile.path;
                  };
                  outDir = "/var/lib/AccountsService";
                  iconsDir = "${outDir}/icons";
                  usersDir = "${outDir}/users";
                  iconFilePath = "${iconsDir}/${username}";
                  userFilePath = "${usersDir}/${username}";
                  userFileContents = pkgs.writeText "accounts-service-${username}" ''
                    [User]
                    Icon=${iconFilePath}
                  '';
                in
                # man 5 tmpfiles.d
                [
                  "L+ ${iconFilePath} 644 ${username} ${username} - ${imageFile}"
                  "L+ ${userFilePath} 644 ${username} ${username} - ${userFileContents}"
                ];
            };
            darwin = { };
          }
        )
      )
    ];
}
