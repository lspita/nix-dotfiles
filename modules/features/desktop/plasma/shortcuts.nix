{ lib, lib2, ... }: {
  lib2.plasma.shortcuts = rec {
    mkFromOption = lib.concatStringsSep "+";

    mkOption = opt: lib.mkOption (opt // { apply = mkFromOption; });
  };

  den.aspects.desktop.plasma.shortcuts.homeManager =
    { host, ... }:
    let
      rangeOptions =
        {
          zeroToTen ? true,
          min ? 0,
          max ? 9,
        }:
        key: value:
        builtins.foldl' (
          result: i:
          let
            istr = toString i;
            displayI = if zeroToTen && i == 0 then 10 else i;
            displayIstr = toString displayI;
          in
          result // { "${key displayIstr}" = value istr; }
        ) { } (lib.lists.range min max);

      plasmaDefaultOrCustomIfPresent =
        program: shortcut:
        let
          plasmaDefaultApp = lib2.plasma.programs.${program}.meta or null;
          customApp = lib2.optionals.getOrDefault plasmaDefaultApp host.programs.${program};
        in
        (lib.optionalAttrs (!isNull plasmaDefaultApp && !isNull plasmaDefaultApp.desktop) {
          "services/${plasmaDefaultApp.desktop}" = {
            "_launch" = "none";
          };
        })
        // (lib.optionalAttrs (!isNull customApp && !isNull customApp.desktop) {
          # override plasma default terminal if null
          "services/${customApp.desktop}" = {
            "_launch" = shortcut;
          };
        });
    in
    {
      programs.plasma.shortcuts =
        # kglobalshortcutsrc
        {
          kwin = {
            # Overview = "Meta"; # Meta+W
            "Window Close" = "Meta+Q"; # Alt+F4
            "MoveMouseToFocus" = "none"; # Meta+F5
            "MoveMouseToCenter" = "none"; # Meta+F6
            "Walk Through Windows" = "Alt+Tab"; # Alt+Tab, Meta+Tab
            "Walk Through Windows (Reverse)" = "Alt+Shift+Tab"; # Alt+Shift+Tab, Meta+Shift+Tab
            "Walk Through Windows of Current Application" = "Meta+Tab"; # Alt+`
            "Walk Through Windows of Current Application (Reverse)" = "Meta+Shift+Tab"; # Alt+~
          }
          // (rangeOptions { } (i: "Switch to Desktop ${i}") (i: [
            "Meta+${i}"
            "Meta+Num+${i}"
          ])) # Ctrl+F<i>
          // (rangeOptions { } (i: "Switch to Screen ${i}") (i: "none")) # Meta+<i>
          # Meta+Shift+<i> doesn't work because it registers as Meta+<special char of number>
          // (rangeOptions { } (i: "Window to Desktop ${i}") (i: [
            "Meta+Shift+${i}"
            "Meta+Shift+Num+${i}"
          ])); # None

          plasmashell = {
            # "activate application launcher" = "Meta+A"; # Meta
            "manage activities" = "none"; # Meta+Q
          }
          // (rangeOptions { } (i: "activate task manager entry ${i}") (i: [
            "Meta+Alt+${i}"
            "Meta+Alt+Num+${i}"
          ])); # Meta-<i>

          org_kde_powerdevil.powerProfile = "none"; # Meta+B
        }
        // (plasmaDefaultOrCustomIfPresent "terminal" "Meta+Return") # Ctrl+Alt+T
        // (plasmaDefaultOrCustomIfPresent "fileManager" "Meta+F") # Meta+E
        // (plasmaDefaultOrCustomIfPresent "browser" "Meta+B")
        // (plasmaDefaultOrCustomIfPresent "editor" "Meta+E");
    };
}
