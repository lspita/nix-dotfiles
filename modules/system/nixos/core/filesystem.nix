{
  config,
  customLib,
  pkgs,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "nixos"
    "core"
    "filesystem"
  ];
  mkConfig =
    { ... }:
    {
      environment.systemPackages = with pkgs; [
        # exfat support
        exfat
        exfatprogs
      ];
    };
}
