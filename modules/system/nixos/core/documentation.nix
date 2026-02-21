{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./documentation.nix {
  config = {
    # https://wiki.nixos.org/wiki/Man_pages
    # https://search.nixos.org/options?channel=unstable&query=documentation
    environment.systemPackages = with pkgs; [
      man-pages
      man-pages-posix
    ];
    documentation = {
      enable = true;
      nixos.enable = true;
      info.enable = true;
      doc.enable = true;
      man.enable = true;
      dev.enable = true;
    };
  };
}
