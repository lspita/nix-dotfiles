{
  customLib,
  config,
  pkgs,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "packages"
  ];
  mkConfig =
    { ... }:
    {
      home.packages = with pkgs; [
        nixd
        nil
        firefox
        git
        vlc
        spotify
      ];
    };
}
