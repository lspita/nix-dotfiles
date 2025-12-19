{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./fzf.nix {
  options = {
    fd.enable = utils.mkTrueEnableOption "fd as the file/dir search command";
  };
  config =
    { self, ... }:
    {
      assertions = [
        {
          assertion = (utils.isInstalled inputs "fd") || !self.fd.enable;
          message = "fd must be installed to use it with fzf";
        }
      ];
      programs.fzf = {
        enable = true;
      }
      // (
        if self.fd.enable then
          let
            # https://github.com/junegunn/fzf?tab=readme-ov-file#respecting-gitignore
            fdFile = "fd --type f --strip-cwd-prefix";
            fdDir = "fd --type d --strip-cwd-prefix";
          in
          {
            defaultCommand = fdFile;
            changeDirWidgetCommand = fdDir;
            fileWidgetCommand = fdFile;
          }
        else
          { }
      );
    };
}
