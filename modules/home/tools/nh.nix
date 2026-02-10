{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./nh.nix {
  options = {
    functions.enable = modules.mkEnableOption true "flake shell functions";
  };
  config =
    { self, ... }:
    {
      programs.nh = {
        enable = true;
        flake = dotfiles.dotRoot inputs;
      };
      custom.shell.rc = lib.lists.optionals self.functions.enable (
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
              nh os switch $@
            }
          ''
          ''
            flake-switch() {
              git ${gitFlakeRef} add .
              nh os switch $@
            }
          ''
          ''
            flake-update() {
              local push=''${1:-true}
              nh os switch -u
              if [ $push = true ]; then
                flake-push "auto: flake update"
              fi
            }
          ''
          ''
            flake-undo-update() {
              git ${gitFlakeRef} restore ${flakeRef}/flake.lock
              nh os switch
            }
          ''
          ''
            flake-init() {
              nix flake init -t ${flakeRef}#"''${1:-devshell}"
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
      );
    };
}
