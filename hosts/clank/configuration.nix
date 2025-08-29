{
  ...
}:
{
  modules.nixos = {
    # base system
    core.enable = true;
    # login
    login.gdm.enable = true;
    # desktop
    desktop.gnome.enable = true;
  };
}
