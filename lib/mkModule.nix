{ lib, ... }:
{
  config,
  path,
  name ? null,
  extraOptions ? { },
  mkConfig,
}:
let
  modulePath = [ "modules" ] ++ path;
  moduleName = if builtins.isNull name then lib.concatStringsSep "." modulePath else name;
  cfg = lib.attrsets.getAttrFromPath modulePath config;
in
{
  options = lib.attrsets.setAttrByPath modulePath (
    {
      enable = lib.mkEnableOption moduleName;
    }
    // extraOptions
  );
  config = lib.mkIf cfg.enable (mkConfig {
    inherit cfg;
  });
}
