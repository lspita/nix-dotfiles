{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./fzf.nix {
  options = {
    fd.enable = modules.mkEnableOption true "fd as the file/dir search command";
  };
  config =
    { self, ... }:
    {
      programs.fzf = {
        enable = true;
      }
      // (lib.attrsets.optionalAttrs self.fd.enable (
        let
          fd = "${pkgs.fd}/bin/fd";
          # https://github.com/junegunn/fzf?tab=readme-ov-file#respecting-gitignore
          fdFile = "${fd} --type f --strip-cwd-prefix";
          fdDir = "${fd} --type d --strip-cwd-prefix";
        in
        {
          defaultCommand = fdFile;
          changeDirWidgetCommand = fdDir;
          fileWidgetCommand = fdFile;
        }
      ));
    };
}
