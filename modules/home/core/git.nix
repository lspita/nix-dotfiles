{
  config,
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./git.nix {
  config =
    let
      attributesConfigPath = "git/attributes";
    in
    {
      # https://github.com/ryan4yin/nix-config/blob/c56593516d8309557f4b74e60add8e2a36f0bf95/home/base/core/git.nix#L9
      # `programs.git` will generate the config file: ~/.config/git/config
      # to make git use this config file, `~/.gitconfig` should not exist!
      #
      #   https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
      home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
        rm -f ${dotfiles.homeDir inputs}/.gitconfig
      '';

      home.packages = with pkgs; [ git-filter-repo ];

      programs.git = with vars.user; {
        enable = true;
        settings = {
          user = {
            name = fullname;
          }
          // (utils.ifNotNull { } {
            inherit email;
          } email);
          init.defaultBranch = "main";
          pull.rebase = false;
          core = {
            attributesfile = "${config.xdg.configHome}/${attributesConfigPath}";
          };
        };
      };
      xdg.configFile = {
        ${attributesConfigPath}.text = ''
          * text=auto eol=lf
          *.[cC][mM][dD] text eol=crlf
          *.[bB][aA][tT] text eol=crlf
          *.[pP][sS]1 text eol=crlf
        '';
      };
    };
}
