{ lib, config, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./fzf.nix {
  options = {
    fd.enable = modules.mkEnableOption true "fd as the file/dir search command";
  };
  config =
    { self, ... }:
    {
      assertions = [
        {
          assertion = (packages.isInstalled inputs "fd") || !self.fd.enable;
          message = "fd must be installed to use it with fzf";
        }
      ];
      programs.fzf = {
        enable = true;
      }
      // (lib.attrsets.optionalAttrs self.fd.enable (
        let
          # hidden flag is given with alias, doesn't work with fzf
          fd = "fd" + (if config.programs.fd.hidden then " --hidden" else "");
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
