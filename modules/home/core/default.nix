{ customLib, config, ... }:
{
  imports = customLib.scanPaths ./.;
}
// customLib.mkModule {
  inherit config;
  path = [
    "core"
  ];
  name = "default core programs and settings";
  mkConfig =
    { ... }:
    {
      modules.core = {
        git.enable = true;
        nix.enable = true;
      };
    };
}
