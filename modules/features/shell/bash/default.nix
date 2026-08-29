{
  den,
  lib,
  lib2,
  ...
}:
{
  den.aspects.shell.bash = {
    includes = with den.aspects; [
      shell
      shell.bash.autocd
    ];

    provides.to-host.os.programs.bash.enable = true;

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

    autocd.homeManager.features.shell.rc = [ "shopt -s autocd" ];
  };
}
