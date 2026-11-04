{
  den.aspects.desktop.plasma.programs.plasma-keyboard.homeManager =
    { pkgs, ... }:
    let
      package = pkgs.kdePackages.plasma-keyboard;
      desktopPath = "${package}/share/applications/org.kde.plasma.keyboard.desktop";
    in
    {
      home.packages = [ package ];
      programs.plasma.configFile.kwinrc = {
        Wayland = {
          InputMethod = {
            value = desktopPath;
            shellExpand = true; # enabling it from the gui settings puts $e
          };
          VirtualKeyboardEnabled = true;
        };
      };
    };
}
