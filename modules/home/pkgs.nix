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
        #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        #  wget
        zed-editor
        nixd
        nil
        firefox
        git
      ];
    };
}
