{
  super,
  lib,
  ...
}:
{
  importPath,
  config,
  path,
  extraOptions ? { },
  mkConfig ? null,
}:
{
  imports = super.scanPaths importPath;
}
// (
  # if instead of lib.mkIf for lazy evaluation
  if builtins.isNull mkConfig then
    { }
  else
    (super.mkModule {
      inherit
        config
        path
        mkConfig
        extraOptions
        ;
      enableOption = "enableDefaults";
      name = with super.moduleUtils; "defaults for ${moduleName (modulePath path)}";
    })
)
