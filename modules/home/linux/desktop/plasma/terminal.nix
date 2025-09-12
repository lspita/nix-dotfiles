{
  config,
  customLib,
  vars,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "plasma"
    "terminal"
  ];
  mkConfig =
    { ... }:
    {
      programs.plasma = with vars.linux.defaultApps; {
        configFile.kdeglobals.General = {
          TerminalApplication.value = terminal.program;
          TerminalService.value = terminal.desktop;
        };
        shortcuts =
          let
            defaultPlasmaTerminal = "org.kde.konsole.desktop";
          in
          {
            "services/${defaultPlasmaTerminal}" = {
              "_launch" = "None";
            };
          }
          // {
            "services/${terminal.desktop}" = {
              "_launch" = "Meta+Return";
            };
          };
      };
    };
}
