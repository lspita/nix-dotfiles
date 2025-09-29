{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./nh.nix {
  options = {
    aliases = utils.mkTrueEnableOption "nh aliases";
  };
  config =
    { self, root, ... }:
    {
      programs.nh = {
        enable = true;
        flake = dotfiles.dotRoot config;
      };
      custom.shell.functions =
        if self.aliases then
          let
            flakeRef = "$NH_FLAKE";
            gitFlakeRef = "-C ${flakeRef}";
          in
          {
            flake-pull = "git ${gitFlakeRef} pull";
            flake-push = ''
              git ${gitFlakeRef} add .
              git ${gitFlakeRef} commit -m "$1"
              git ${gitFlakeRef} push
            '';
            flake-sync = ''
              flake-pull
              nh os switch -u
              flake-push "''${1-"flake update"}"
            '';
          }
        else
          { };
    };
}
