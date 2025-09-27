{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./adw-gtk3.nix {
  config = {
    home.packages = with pkgs; [ adw-gtk3 ];
    dconf.settings."org/gnome/desktop/interface".gtk-theme = "adw-gtk3";
  };
}
