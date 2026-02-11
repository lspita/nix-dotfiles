{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./shortcuts.nix {
  config = {
    custom.linux.desktop.plasma = {
      appearance.koi.shortcuts.toggle = "Meta+F5";
      apps.krunner.shortcuts.launch = "Meta"; # Alt+Space
    };
    programs.plasma.shortcuts =
      # kglobalshortcutsrc
      let
        rangeOptions =
          {
            min ? 0,
            max ? 9,
          }:
          key: value:
          builtins.foldl' (
            result: i:
            let
              newI = if i == 0 then 10 else i;
              istr = toString newI;
            in
            result // { "${key istr}" = value istr; }
          ) { } (lib.lists.range min max);
      in
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
          "activate application launcher" = "Meta+A"; # Meta
          "manage activities" = "Meta+W"; # Meta+Q
        }
        // (rangeOptions { } (i: "activate task manager entry ${i}") (i: [
          "Meta+Alt+${i}"
          "Meta+Alt+Num+${i}"
        ])); # Meta-<i>

        org_kde_powerdevil.powerProfile = "none"; # Meta+B
      }
      // (
        let
          plasmaDefaultOrCustomIfPresent =
            app: shortcut:
            let
              plasmaDefaultApp = plasma.defaults.apps.${app} or null;
              customApp = optionals.getNotNull plasmaDefaultApp vars.linux.defaultApps.${app};
            in
            (optionals.ifNotNull { } {
              "services/${plasmaDefaultApp.desktop}" = {
                "_launch" = "none";
              };
            } plasmaDefaultApp)
            // (lib.attrsets.optionalAttrs (plasmaDefaultApp != null || customApp != null) {
              # override plasma default terminal if null
              "services/${customApp.desktop}" = {
                "_launch" = shortcut;
              };
            });
        in
        (plasmaDefaultOrCustomIfPresent "terminal" "Meta+Return") # Ctrl+Alt+T
        // (plasmaDefaultOrCustomIfPresent "fileManager" "Meta+F") # Meta+E
        // (plasmaDefaultOrCustomIfPresent "browser" "Meta+B")
        // (plasmaDefaultOrCustomIfPresent "editor" "Meta+E")
      );
  };
}
