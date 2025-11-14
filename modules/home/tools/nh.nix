{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./nh.nix {
  options = {
    functions.enable = utils.mkTrueEnableOption "flake shell functions";
  };
  config =
    { self, root, ... }:
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
              flake-update() {
                nh os switch -u
                flake-push "auto: flake update"
              }
            ''
            ''
              flake-init() {
                nix flake init -t $NH_FLAKE#"$1"
              }
            ''
          ]
        else
          [ ];
    };
}
