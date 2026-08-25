{ flake, den, lib, ... }:
{
  den.aspects.shell.zsh = {
    includes = with den.aspects; [ shell ];

    provides.to-host.os.programs.zsh.enable = true;

    homeManager =
      { config, shellrc, ... }:
      {
        programs.zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          autocd = true;
          dotDir = "${config.xdg.configHome}/zsh";
          initContent = lib.mkAfter (flake.lib.shell.mkShellrc "zsh" shellrc);
        };
        home.shell.enableZshIntegration = true;
      };
  };
}
