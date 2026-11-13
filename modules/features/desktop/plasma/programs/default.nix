{
  den,
  meta,
  lib,
  lib2,
  ...
}:
{
  lib2.plasma.programs =
    let
      programs = meta.programs;
      aspects = den.aspects.desktop.plasma.programs;
    in
    {
      editor = {
        pkgs = (pkgs: with pkgs.kdePackages; [ kate ]);
        meta = programs.kwrite;
        aspect = aspects.kate;
      };
      fileManager = {
        pkgs = (pkgs: with pkgs.kdePackages; [ dolphin ]);
        meta = programs.dolphin;
        aspect = aspects.dolphin;
      };
      terminal = {
        pkgs = (pkgs: with pkgs.kdePackages; [ konsole ]);
        meta = programs.konsole;
        aspect = aspects.konsole;
      };
    };

  den.aspects.desktop.plasma.programs =
    let
      program = p: lib2.plasma.programs.${p};
      programAspect = p: (program p).aspect;
      programPkgs = pkgs: p: (program p).pkgs pkgs;
      programMeta = p: (program p).meta;
      replacementProgramAspect =
        host: p:
        if isNull host.programs.${p} then
          {
            includes = [ (programAspect p) ];
            nixos = { pkgs, ... }: {
              environment.systemPackages = programPkgs pkgs p;
            };
          }
        else
          {
            nixos = { pkgs, ... }: {
              environment.plasma6.excludePackages = programPkgs pkgs p;
            };
          };
    in
    {
      includes = with den.aspects.desktop.plasma.programs; [
        file-manager
        editor
        terminal
        plasma-keyboard
      ];

      file-manager = { host, ... }: replacementProgramAspect host "fileManager";

      editor.includes = [ (programAspect "editor") ];

      terminal = { host, ... }: {
        includes = [ (replacementProgramAspect host "terminal") ];
        homeManager.programs.plasma.configFile.kdeglobals.General =
          let
            plasmaTerminal = programMeta "terminal";
            terminal = lib2.optionals.getOrDefault plasmaTerminal host.programs.terminal;
          in
          {
            TerminalApplication = terminal.exec;
          }
          // (lib.optionalAttrs (!isNull terminal.desktop) {
            TerminalService = terminal.desktop;
          });
      };
    };
}
