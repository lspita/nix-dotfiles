{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./fzf.nix {
  options = {
    fd.enable = modules.mkEnableOption true "fd as the file/dir search command";
    shellIntegration.enable = modules.mkEnableOption true "fzf shell integration";
  };
  config =
    { self, ... }:
    lib.mkMerge [
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
      }
      (lib.mkIf self.shellIntegration.enable (
        # https://github.com/junegunn/fzf#setting-up-shell-integration
        let
          integrationScripts = {
            bash = ''
              eval "$(fzf --bash)"
            '';
            zsh = ''
              source <(fzf --zsh)
            '';
            fish = ''
              fzf --fish | source
            '';
            nushell = ''
              mkdir ($nu.default-config-dir | path join "autoload")
              fzf --nushell | save -f ($nu.default-config-dir | path join "autoload" "_fzf_integration.nu")
            '';
          };
        in
        {
          custom.shell.rc = [
            (shell: integrationScripts.${shell} or "")
          ];
        }
      ))
    ];
}
