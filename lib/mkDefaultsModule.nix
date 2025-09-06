{ super }:
{
  config,
  importPath,
  path,
  imports ? [ ],
  extraOptions ? { },
  mkConfig ? null,
}:
# if instead of lib.mkIf for lazy evaluation
let
  totalImports = imports ++ (super.scanPaths importPath);
in
if builtins.isNull mkConfig then
  {
    imports = totalImports;
  }
else
  super.mkModule {
    inherit
      config
      path
      extraOptions
      mkConfig
      ;
    imports = totalImports;
    enableOption = "enableDefaults";
    name = with super.moduleUtils; "defaults for ${moduleName (modulePath path)}";
  }
