{
  config,
  customLib,
  pkgs,
  vars,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "git"
  ];
  mkConfig =
    { ... }:
    let
      uvars = vars.user;
    in
    {
      programs.git = {
        package = pkgs.git;
        enable = true;
        userName = uvars.username;
        userEmail = uvars.email;
        extraConfig = {
          init.defaultBranch = "main";
          pull.rebase = false;
          core = {
            editor = vars.editor;
          };
        };
      };
    };
}
