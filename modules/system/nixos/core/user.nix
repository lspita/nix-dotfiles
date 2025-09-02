{
  config,
  customLib,
  vars,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "nixos"
    "core"
    "user"
  ];
  mkConfig =
    { ... }:
    {
      custom.modules.user.enable = true;
      users.users.${vars.user.username} = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
        ];
      };
    };
}
