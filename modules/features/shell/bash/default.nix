{
  flake,
  den,
  lib,
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
          initExtra = lib.mkAfter (flake.lib.shell.mkShellrc "bash" shellrc);
        };
        home.shell.enableBashIntegration = true;
      };

    autocd.shellrc = "shopt -s autocd";
  };
}
