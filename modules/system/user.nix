{
  config,
  customLib,
  vars,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "user"
  ];
  mkConfig =
    { ... }:
    let
      uvars = vars.user;
    in
    {
      users.users.${uvars.username} = {
        description = uvars.fullname;
      };
    };
}
