{ lib, ... }:
{
  config,
  path,
  name ? null,
  enableOption ? "enable",
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
      ${enableOption} = lib.mkEnableOption moduleName;
    }
    // extraOptions
  );
  config = lib.mkIf cfg.${enableOption} (mkConfig {
    inherit cfg;
  });
}
