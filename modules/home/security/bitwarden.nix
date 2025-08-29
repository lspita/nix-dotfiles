{
  config,
  customLib,
  pkgs,
  lib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "security"
    "bitwarden"
  ];
  extraOptions = {
    sshAgent = lib.mkOption {
      type = lib.types.str;
      default = "weekly";
      description = "How often or when garbage collection is performed.";
    };
  };
  mkConfig =
    { ... }:
    {
      home.packages = with pkgs; [
        bitwarden-desktop
      ];
    };
}
