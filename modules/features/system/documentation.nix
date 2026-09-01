{
  den.aspects.system.documentation = {
    # https://wiki.nixos.org/wiki/Man_pages
    # https://search.nixos.org/options?channel=unstable&query=documentation
    os = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        man-pages
        man-pages-posix
      ];
      documentation = {
        enable = true;
        info.enable = true;
        doc.enable = true;
        man.enable = true;
      };
    };

    nixos.documentation = {
      nixos.enable = true;
      dev.enable = true;
    };
  };
}
