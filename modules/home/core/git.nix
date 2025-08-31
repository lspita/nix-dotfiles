{
  config,
  customLib,
  lib,
  vars,
  pkgs,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "core"
    "git"
  ];
  mkConfig =
    { ... }:
    let
      uvars = vars.user;
      attributesConfigPath = "git/attributes";
    in
    {
      # https://github.com/ryan4yin/nix-config/blob/c56593516d8309557f4b74e60add8e2a36f0bf95/home/base/core/git.nix#L9
      # `programs.git` will generate the config file: ~/.config/git/config
      # to make git use this config file, `~/.gitconfig` should not exist!
      #
      #   https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
      home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
        rm -f ${config.home.homeDirectory}/.gitconfig
      '';

      home.packages = with pkgs; [ git-filter-repo ];

      programs.git = {
        enable = true;
        userName = uvars.fullname;
        userEmail = uvars.email;
        extraConfig = {
          init.defaultBranch = "main";
          pull.rebase = false;
          core = {
            editor = vars.editor;
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
