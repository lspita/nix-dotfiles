{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./user.nix {
  config = with vars.user; {
    users.users.${username} = {
      description = fullname;
    }
    // (utils.ifNotNull shell { } { shell = shell pkgs; })
    // (utils.osValue {
      linux = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
        ];
      };
      darwin = { };
    });
  };
}
