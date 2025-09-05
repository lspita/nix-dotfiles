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
    with vars.user;
    {
      users.users.${username} = {
        description = fullname;
      };
    };
}
