{ root }:
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
  totalImports = imports ++ (root.scanPaths importPath);
in
if builtins.isNull mkConfig then
  {
    imports = totalImports;
  }
else
  root.mkModule {
    inherit
      config
      path
      extraOptions
      mkConfig
      ;
    imports = totalImports;
    enableOption = "enableDefaults";
    name = with root.moduleUtils; "defaults for ${moduleName (modulePath path)}";
  }
