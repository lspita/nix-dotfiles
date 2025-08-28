{
  config,
  customLib,
  vars,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "modules"
    "system"
    "nixos"
    "user"
  ];
  mkConfig =
    { ... }:
    {
      modules.system.shared.user.enable = true;
      users.users.${vars.user.username} = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
        ];
      };
    };
}
