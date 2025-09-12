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
    "windowShortcuts"
  ];
  mkConfig =
    { ... }:
    {
      programs.plasma.shortcuts = {
        kwin = {
          Overview = "Meta";
          "Window Close" = "Meta+Q";
        };
        plasmashell = {
          "activate application launcher" = "None";
          "manage activities" = "Meta+W";
        };
      };
    };
}
