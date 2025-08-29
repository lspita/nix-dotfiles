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
    "network"
    "networkmanager"
  ];
  mkConfig =
    { ... }:
    {
      networking.networkmanager.enable = true;
      users.users.${vars.user.username}.extraGroups = [ "networkmanager" ];
    };
}
