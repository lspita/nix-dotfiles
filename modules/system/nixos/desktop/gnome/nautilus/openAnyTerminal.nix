{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./openAnyTerminal.nix {
  config = {
    # https://github.com/Stunkymonkey/nautilus-open-any-terminal
    programs = {
      nautilus-open-any-terminal = {
        enable = true;
        terminal = "custom";
      };
      dconf.profiles.user.databases = [
        {
          settings."com/github/stunkymonkey/nautilus-open-any-terminal" =
            let
              gnomeTerminal = gnome.defaults.terminal.program;
              varsTerminal = vars.linux.defaultApps.terminal.program;
              terminal = utils.getNotNull gnomeTerminal varsTerminal;
            in
            {
              # https://github.com/Stunkymonkey/nautilus-open-any-terminal/blob/253fb95c649ab05641cf7e6b5090a2146b0b1d6c/nautilus_open_any_terminal/schemas/com.github.stunkymonkey.nautilus-open-any-terminal.gschema.xml#L24-L39
              custom-local-command = "${terminal} %s";
              custom-remote-command = "${terminal} %s";
            };
        }
      ];
    };
  };
}
