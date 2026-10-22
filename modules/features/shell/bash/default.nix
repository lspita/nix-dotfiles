{
  den,
  lib,
  lib2,
  ...
}:
{
  den.aspects.shell.bash = {
    includes =
      (with den.aspects; [
        shell
      ])
      ++ (with den.aspects.shell.bash; [
        autocd
      ]);

    os.programs.bash.enable = true;

    homeManager =
      { config, ... }:
      {
        programs.bash = {
          enable = true;
          enableCompletion = true;
          initExtra = lib.mkAfter (lib2.shell.mkShellrc config "bash");
        };
        home.shell.enableBashIntegration = true;
      };

    autocd = {
      includes = with den.aspects; [ shell ];
      homeManager.features.shell.rc = [ "shopt -s autocd" ];
    };
  };
}
