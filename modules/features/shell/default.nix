{ den, lib, ... }: {
  flake.lib.shell.mkShellrc =
    config: shell:
    config.features.shell.rc
    |> map (source: if builtins.isFunction source then source shell else source)
    |> builtins.concatStringsSep "\n";

  den.aspects.shell = {
    includes = with den.aspects; [
      shell.aliases
      shell.input
    ];

    homeManager.options = {
      features.shell.rc = lib.mkOption {
        type = with lib.types; listOf (either str (functionTo str));
        default = [ ];
        description = "Shell rc parts to include";
      };
    };

    aliases.homeManager.home.shellAliases = {
      ll = "ls -al";
      la = "ls -a";
      purge-all = "find . -mindepth 1 -maxdepth 1 -print -exec rm -rf '{}' \\;";
      git-root = "cd $(git rev-parse --show-toplevel)";
    };

    input.homeManager.home.file.".inputrc".text = ''
      set completion-ignore-case on
    '';
  };
}
