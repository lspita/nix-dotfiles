{
  config,
  customLib,
  pkgs,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "plasma"
    "plugin"
    "dynamicWorkspaces"
  ];
  mkConfig =
    { ... }:
    {
      home.packages = with pkgs; [ kdePackages.dynamic-workspaces ];
      programs.plasma.configFile.kwinrc = customLib.plasma.enableKwinScript "dynamic_workspaces" {
        keepEmptyMiddleDesktops = true;
      };
    };
}
