{
  den,
  meta,
  lib2,
  ...
}:
{
  lib2.plasma.programs =
    let
      programs = meta.programs.plasma;
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
    { host, ... }:
    let
      program = p: lib2.plasma.programs.${p};
      programAspect = p: (program p).aspect;
      programPkgs = pkgs: p: (program p).pkgs pkgs;
      replacementProgramAspect =
        p:
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
      includes = [
        (replacementProgramAspect "terminal")
        (replacementProgramAspect "fileManager")
        (programAspect "editor")
      ];
    };
}
