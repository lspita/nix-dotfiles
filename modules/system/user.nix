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
    "user"
  ];
  mkConfig =
    { ... }:
    with vars.user;
    {
      users.users.${username} = {
        description = fullname;
        shell = vars.shell pkgs;
      };
    };
}
