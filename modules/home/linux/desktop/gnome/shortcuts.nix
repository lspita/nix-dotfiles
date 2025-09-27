{
  config,
  lib,
  vars,
  ...
}:
with lib.custom;
modules.mkModule config ./shortcuts.nix {
  config =
    with vars.linux.defaultApps;
    let
      customKeybindings = [
        {
          id = "launch-terminal";
          name = "Launch terminal";
          command = terminal.program;
          binding = "<Super>Return";
        }
      ];
      customKeybindingsRoot = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings";
    in
    {
      dconf.settings = {
        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Super>q" ];
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          help = [ ]; # remove shortcut for gnome help
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
