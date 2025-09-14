{ root, lib }:
{
  config,
  path,
  imports ? [ ],
  name ? null,
  enableOption ? "enable",
  extraOptions ? { },
  mkConfig,
}:
let
  mu = root.moduleUtils;
  modulePath = mu.modulePath path;
  moduleName = if builtins.isNull name then mu.moduleName modulePath else name;
  cfg = lib.attrsets.getAttrFromPath modulePath config;
in
{
  inherit imports;
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
