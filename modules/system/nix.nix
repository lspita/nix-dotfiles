{
  config,
  customLib,
  vars,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "nix"
  ];
  mkConfig =
    { ... }:
    {
      nix.settings = {
        trusted-users = [ vars.user.username ];
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };
}
