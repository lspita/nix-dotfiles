{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./nh.nix {
  options = {
    functions.enable = utils.mkEnableOption true "flake shell functions";
  };
  config =
    { self, ... }:
    {
      programs.nh = {
        enable = true;
        flake = dotfiles.dotRoot inputs;
      };
      custom.shell.rc =
        if self.functions.enable then
          let
            flakeRef = "$NH_FLAKE";
            gitFlakeRef = "-C ${flakeRef}";
          in
          [
            ''
              flake-pull() {
                git ${gitFlakeRef} pull
              }
            ''
            ''
              flake-push() {
                git ${gitFlakeRef} add .
                git ${gitFlakeRef} commit -m "$1"
                git ${gitFlakeRef} push
              }
            ''
            ''
              flake-sync() {
                flake-pull
                nh os switch
              }
            ''
            ''
              flake-switch() {
                git ${gitFlakeRef} add .
                nh os switch
              }
            ''
            ''
              flake-update() {
                nh os switch -u
                local push=''${1:-true}
                if [ $push = true ]; then
                  flake-push "auto: flake update"
                fi
              }
            ''
            ''
              flake-undo-update() {
                git ${gitFlakeRef} restore flake.lock
                nh os switch
              }
            ''
            ''
              flake-init() {
                nix flake init -t ${flakeRef}#"$1"
                ${
                  "git rm --cached .envrc || true" # `|| true` to not give an error if not in a repo
                }
              }
            ''
            ''
              flake-develop() {
                nix develop --no-write-lock-file ${flakeRef}/templates/$1
              }
            ''
          ]
        else
          [ ];
    };
}
