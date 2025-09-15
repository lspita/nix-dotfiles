{
  config,
  lib,
  vars,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "gnome"
    "shortcuts"
  ];
  mkConfig =
    { ... }:
    with vars.linux.defaultApps;
    let
      overrides = {
        close = [ "<Super>q" ];
      };
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
        "org/gnome/desktop/wm/keybindings" = overrides;
        "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = builtins.map (
          kb: "/${customKeybindingsRoot}/${kb.id}/"
        ) customKeybindings;
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
