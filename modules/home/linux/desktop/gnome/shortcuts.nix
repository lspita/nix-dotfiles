{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./shortcuts.nix {
  config =
    let
      getProgramOrGnomeDefault =
        appName:
        let
          varApps = vars.linux.defaultApps;
          gnomeApps = gnome.defaults.apps;
        in
        optionals.ifNotNull (gnomeApps.${appName}.program) varApps.${appName}.program varApps.${appName};
      customKeybindings = [
        {
          id = "launch-files";
          name = "Launch file manager";
          command = getProgramOrGnomeDefault "fileManager";
          binding = "<Super>f";
        }
        {
          id = "launch-terminal";
          name = "Launch terminal";
          command = getProgramOrGnomeDefault "terminal";
          binding = "<Super>Return";
        }
        {
          id = "launch-editor";
          name = "Launch editor";
          command = getProgramOrGnomeDefault "editor";
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
          switch-applications = [ "<Alt>Tab" ];
          switch-applications-backward = [ "<Shift><Alt>Tab" ];
          switch-group = [ "<Super>Tab" ];
          switch-group-backward = [ "<Shift><Super>Tab" ];
          switch-panels = [ ];
          switch-panels-backward = [ ];
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
