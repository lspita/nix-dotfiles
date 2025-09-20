{ root, lib }:
{
  config,
  path,
  packages ? [ ],
  programs ? [ ],
}:
root.mkModule {
  inherit
    config
    path
    ;
  mkConfig =
    { ... }:
    let
      singleOrList = value: if builtins.isList value then value else [ value ];
    in
    {
      home.packages = singleOrList packages;
      programs = builtins.foldl' (result: program: result // { ${program}.enable = true; }) { } (
        singleOrList programs
      );
    };
}
