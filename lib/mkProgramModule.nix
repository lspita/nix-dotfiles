{ root }:
{
  config,
  path,
  packages,
}:
root.mkModule {
  inherit
    config
    path
    ;
  mkConfig =
    { ... }:
    {
      home.packages = if builtins.isList packages then packages else [ packages ];
    };
}
