{
  meta.programs.plasma.dolphin = {
    exec = "dolphin";
    desktop = "org.kde.dolphin.desktop";
  };

  den.aspects.desktop.plasma.programs.dolphin.homeManager = { pkgs, ... }: {
    home.packages = with pkgs.kdePackages; [ dolphin ];
  };
}
