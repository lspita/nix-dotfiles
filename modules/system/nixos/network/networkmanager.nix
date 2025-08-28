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
