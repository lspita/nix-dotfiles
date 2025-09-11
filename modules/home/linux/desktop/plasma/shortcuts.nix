{
  config,
  customLib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "plasma"
    "shortcuts"
  ];
  mkConfig =
    { ... }:
    {
      programs.plasma.shortcuts = {
        kwin = {
          Overview = "Meta";
        };
        plasmashell = {
          "activate application launcher" = "None";
        };
      };
    };
}
