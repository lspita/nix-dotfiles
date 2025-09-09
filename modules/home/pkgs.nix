{
  customLib,
  config,
  pkgs,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "pkgs"
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
