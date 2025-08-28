{ lib, ... }:
{
  config,
  path,
  name ? null,
  extraOptions ? { },
  mkConfig,
}:
let
  moduleName = if builtins.isNull name then lib.concatStringsSep "." path else name;
  cfg = lib.attrsets.getAttrFromPath path config;
in
{
  options = lib.attrsets.setAttrByPath path (
    {
      enable = lib.mkEnableOption moduleName;
    }
    // extraOptions
  );
  config = lib.mkIf cfg.enable (mkConfig {
    inherit cfg;
  });
}
