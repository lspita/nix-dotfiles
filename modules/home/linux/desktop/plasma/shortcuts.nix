{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./shortcuts.nix {
  config = {
    custom.linux.desktop.plasma.appearance.koi.toggle.shortcut = "Meta+F5";
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
          Overview = "Meta";
          "Window Close" = "Meta+Q";
          "MoveMouseToFocus" = ""; # Meta+F5
          "MoveMouseToCenter" = ""; # Meta+F6
        }
        # TODO: fix
        // (rangeOptions { } (i: "Switch to Desktop ${i}") (i: [
          "Meta+${i}"
          "Meta+Num+${i}"
        ])) # Ctrl+F<i>
        // (rangeOptions { } (i: "Switch to Screen ${i}") (i: "")) # Meta+<i>
        # Meta+Shift+<i> doesn't work because it registers as Meta+<special char of number>
        // (rangeOptions { } (i: "Window to Desktop ${i}") (i: "Meta+Shift+${i}")); # None

        plasmashell = {
          "activate application launcher" = "Meta+A"; # Meta
          "manage activities" = "Meta+W"; # Meta+Q
        }
        // (rangeOptions { } (i: "activate task manager entry ${i}") (i: "")); # Meta-<i>

        org_kde_powerdevil.powerProfile = ""; # Meta+B
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
                "_launch" = "";
              };
            } plasmaDefaultApp)
            // (
              if plasmaDefaultApp != null || customApp != null then
                {
                  # override plasma default terminal if null
                  "services/${customApp.desktop}" = {
                    "_launch" = shortcut;
                  };
                }
              else
                { }
            );
        in
        (plasmaDefaultOrCustomIfPresent "terminal" "Meta+Return") # Ctrl+Alt+T
        // (plasmaDefaultOrCustomIfPresent "fileManager" "Meta+F") # Meta+E
        // (plasmaDefaultOrCustomIfPresent "browser" "Meta+B") # None
        // (plasmaDefaultOrCustomIfPresent "editor" "Meta+E") # None
      );
  };
}
