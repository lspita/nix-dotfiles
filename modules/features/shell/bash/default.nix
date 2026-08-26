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
      { shellrc, ... }:
      {
        programs.bash = {
          enable = true;
          enableCompletion = true;
          initExtra = lib.mkAfter (lib2.shell.mkShellrc "bash" shellrc);
        };
        home.shell.enableBashIntegration = true;
      };

    autocd.shellrc = "shopt -s autocd";
  };
}
