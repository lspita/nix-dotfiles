{ root, vars }:
# string: full path to user home directory
{ config, ... }@inputs: # set: config inputs
root.platform.configTypeValue inputs {
  home = config.home.homeDirectory;
  system = config.users.users.${vars.user.username}.home;
}
