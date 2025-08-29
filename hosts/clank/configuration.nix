{
  ...
}:
{
  modules.nixos = {
    core.enable = true;
    login = {
      gdm.enable = true;
    };
    desktop = {
      gnome.enable = true;
    };
  };
}
