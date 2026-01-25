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
  };
}
