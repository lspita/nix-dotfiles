{
  ...
}:
{
  modules.system.nixos = {
    # base system
    boot.enable = true;
    wayland.enable = true;
    locale.enable = true;
    services.enable = true;
    user.enable = true;
    # login + desktop
    login.gdm.enable = true;
    desktop.gnome.enable = true;
    # audio
    audio.pipewire.enable = true;
  };
}
