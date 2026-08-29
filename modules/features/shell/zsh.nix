{
  den,
  lib,
  lib2,
  ...
}:
{
  den.aspects.shell.zsh = {
    includes = with den.aspects; [ shell ];

    provides.to-host.os.programs.zsh.enable = true;

    homeManager =
      { config, ... }:
      {
        programs.zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          autocd = true;
          dotDir = "${config.xdg.configHome}/zsh";
          initContent = lib.mkAfter (lib2.shell.mkShellrc config "zsh");
        };
        home.shell.enableZshIntegration = true;
      };
  };
}
