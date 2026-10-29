{
  meta.programs.plasma = {
    kwrite = {
      exec = "kwrite";
      desktop = "org.kde.kwrite.desktop";
    };
    kate = {
      exec = "kate";
      desktop = "org.kde.kate.desktop";
    };
  };

  den.aspects.desktop.plasma.programs.kate.homeManager = { pkgs, ... }: {
    home.packages = with pkgs.kdePackages; [ kate ]; # provides both kate and kwrite

    programs.plasma.configFile.kwriterc = {
      "KTextEditor View"."Scroll Past End" = true;
    };
  };
}
