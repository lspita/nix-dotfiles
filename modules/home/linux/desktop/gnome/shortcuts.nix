{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./shortcuts.nix {
  config =
    with vars.linux.defaultApps;
    let
      customKeybindings =
        [ ]
        ++ (utils.ifNotNull terminal.program
          [ ]
          [
            {
              id = "launch-terminal";
              name = "Launch terminal";
              command = terminal.program;
              binding = "<Super>Return";
            }
            {
              id = "launch-files";
              name = "Launch file manager";
              command = utils.getNotNull "nautilus" fileManager;
              binding = "<Super>f";
            }
          ]
        );
      customKeybindingsRoot = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings";
    in
    {
      dconf.settings = {
        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Super>q" ];
          toggle-fullscreen = [ "<Super>F11" ];
        }
        // (builtins.foldl'
          (
            result: i:
            let
              istr = builtins.toString i;
            in
            result
            // {
              "move-to-workspace-${istr}" = [ "<Shift><Super>${istr}" ];
              "switch-to-workspace-${istr}" = [ "<Super>${istr}" ];
              "switch-to-application-${istr}" = [ ];
            }
          )
          {
            move-to-workspace-last = [ "<Shift><Super>0" ];
            switch-to-workspace-last = [ "<Super>0" ];
            switch-to-application-10 = [ ];
          }
          (lib.lists.range 1 9)
        );
        "org/gnome/settings-daemon/plugins/media-keys" = {
          help = [ ]; # remove shortcut for gnome help
          www = [ "<Super>b" ]; # launch browser
          custom-keybindings = builtins.map (kb: "/${customKeybindingsRoot}/${kb.id}/") customKeybindings;
        };
      }
      // (builtins.foldl' (
        result: kb:
        result
        // {
          "${customKeybindingsRoot}/${kb.id}" = {
            inherit (kb) name command binding;
          };
        }
      ) { } customKeybindings);
    };
}
