{
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./custom/gnome-touchpad-resize.nix
  ];

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
}
