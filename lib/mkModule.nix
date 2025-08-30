{ lib, super, ... }:
{
  config,
  path,
  name ? null,
  enableOption ? "enable",
  extraOptions ? { },
  mkConfig,
}:
let
  mu = super.moduleUtils;
  modulePath = mu.modulePath path;
  moduleName = if builtins.isNull name then mu.moduleName modulePath else name;
  cfg = lib.attrsets.getAttrFromPath modulePath config;
in
{
  options = lib.attrsets.setAttrByPath modulePath (
    {
      ${enableOption} = lib.mkEnableOption moduleName;
    }
    // extraOptions
  );
  config = lib.mkIf (cfg.${enableOption}) (mkConfig {
    inherit cfg;
  });
}
