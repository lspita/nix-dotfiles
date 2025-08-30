{
  ...
}:
{
  modules = {
    nixos = {
      core.enableDefaults = true;
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
  };

  system.stateVersion = "25.05"; # do not touch
}
