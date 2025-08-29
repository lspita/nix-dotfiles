{
  ...
}:
{
  modules.nixos = {
    core.enableDefaultModules = true;
    login = {
      gdm.enable = true;
    };
    desktop = {
      gnome = {
        enable = true;
        sshAgent.enable = false; # use bitwarden instead
      };
    };
  };
}
