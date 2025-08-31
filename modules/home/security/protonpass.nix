{
  config,
  customLib,
  pkgs,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "security"
    "protonpass"
  ];
  mkConfig =
    { ... }:
    {
      home = {
        packages = with pkgs; [
          proton-pass
        ];
      };
    };
}
