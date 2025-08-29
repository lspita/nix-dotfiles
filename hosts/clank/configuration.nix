{
  ...
}:
{
  modules.nixos = {
    # base system
    defaultModules = true;
    # login
    login.gdm.enable = true;
    # desktop
    desktop.gnome.enable = true;
    # audio
    audio.pipewire.enable = true;
  };
}
