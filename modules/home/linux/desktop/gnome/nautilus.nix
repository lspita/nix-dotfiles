{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./nautilus.nix {
  config = {
    dconf.settings."org/gnome/nautilus/preferences" = {
      show-create-link = true;
      show-delete-permanently = true;
    };
  };
}
