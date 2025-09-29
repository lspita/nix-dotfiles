{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./. {
  options = {
    completition = {
      enable = utils.mkTrueEnableOption "bash completition";
      ignoreCase = utils.mkTrueEnableOption "case-insensitive completition";
    };
  };
  config =
    { self, ... }:
    {
      programs = {
        bash = {
          enable = true;
          enableCompletion = self.completition.enable;
          initExtra = lib.mkAfter (shell.loadrc config "bash");
        };
      };
      # https://www.cyberciti.biz/faq/bash-shell-setup-filename-tab-completion-case-insensitive/
      home.file.".inputrc".text = ''
        ${if self.completition.ignoreCase then "set completion-ignore-case on" else ""}
      '';
    };
}
