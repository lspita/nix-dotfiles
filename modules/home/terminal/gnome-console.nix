{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./gnome-console.nix {
  config = {
    home.packages = with pkgs; [ gnome-console ];
    dconf.settings."org/gnome/Console" = {
      theme = "auto";
      font-scale = 1.1;
    };
  };
}
