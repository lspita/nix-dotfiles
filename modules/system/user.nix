{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
with lib.custom;
modules.mkModule config ./user.nix {
  config = with vars.user; {
    users.users.${username} = {
      description = fullname;
      shell = vars.shell pkgs;
    }
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
