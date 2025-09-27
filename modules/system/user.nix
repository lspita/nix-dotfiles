{
  config,
  lib,
  pkgs,
  vars,
  systemType,
  ...
}:
with lib.custom;
let
  osConfig = {
    linux = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
      ];
    };
    darwin = { };
  };
in
modules.mkModule config ./user.nix {
  config = with vars.user; {
    users.users.${username} = {
      description = fullname;
      shell = vars.shell pkgs;
    }
    // osConfig.${systemType};
  };
}
