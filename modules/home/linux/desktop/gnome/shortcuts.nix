{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./shortcuts.nix {
  config =
    with vars.linux.defaultApps;
    let
      customKeybindings = [
        {
          id = "launch-files";
          name = "Launch file manager";
          command = utils.getNotNull gnome.defaults.fileManager.program fileManager.program;
          binding = "<Super>f";
        }
        {
          id = "launch-terminal";
          name = "Launch terminal";
          command = utils.getNotNull gnome.defaults.terminal.program terminal.program;
          binding = "<Super>Return";
        }
        {
          id = "launch-editor";
          name = "Launch editor";
          command = utils.getNotNull gnome.defaults.editor.program editor.program;
          binding = "<Super>E";
        }
      ];
      customKeybindingsRoot = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings";
      rangeOptions =
        {
          min ? 0,
          max ? 9,
        }:
        key: value:
        builtins.foldl' (
          result: i:
          let
            istr = toString i;
          in
          result // { "${key istr}" = value istr; }
        ) { } (lib.lists.range min max);
      switchToApplicationOptions = rangeOptions {
        min = 1;
        max = 10;
      } (i: "switch-to-application-${i}") (i: [ ]);
      zeroToLast = i: if i == "0" then "last" else i;
    in
    {
      dconf.settings = {
        "org/gnome/shell/keybindings" = switchToApplicationOptions;
        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Super>q" ];
          toggle-fullscreen = [ "<Super>F11" ];
        }
        // (rangeOptions { } (i: "switch-to-workspace-${zeroToLast i}") (i: [ "<Super>${i}" ]))
        // (rangeOptions { } (i: "move-to-workspace-${zeroToLast i}") (i: [ "<Shift><Super>${i}" ]))
        // switchToApplicationOptions;
        "org/gnome/settings-daemon/plugins/media-keys" = {
          help = [ ]; # remove shortcut for gnome help
          www = [ "<Super>b" ]; # launch browser
          custom-keybindings = map (kb: "/${customKeybindingsRoot}/${kb.id}/") customKeybindings;
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
