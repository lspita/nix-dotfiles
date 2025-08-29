{ customLib, config, ... }:
{
  imports = customLib.scanPaths ./.;
}
// customLib.mkModule {
  inherit config;
  path = [
    "core"
  ];
  enableOption = "enableDefaults";
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
