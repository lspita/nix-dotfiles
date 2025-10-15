{ root, vars }:
{ config, ... }@inputs:
root.utils.configTypeValue inputs {
  home = config.home.homeDirectory;
  system = config.users.users.${vars.user.username}.home;
}
