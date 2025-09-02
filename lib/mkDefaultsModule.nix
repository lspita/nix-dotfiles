{ super }:
{
  config,
  importPath,
  path,
  extraOptions ? { },
  mkConfig ? null,
}:
# if instead of lib.mkIf for lazy evaluation
let
  imports = super.scanPaths importPath;
in
if builtins.isNull mkConfig then
  {
    inherit imports;
  }
else
  super.mkModule {
    inherit
      config
      path
      imports
      extraOptions
      mkConfig
      ;
    enableOption = "enableDefaults";
    name = with super.moduleUtils; "defaults for ${moduleName (modulePath path)}";
  }
