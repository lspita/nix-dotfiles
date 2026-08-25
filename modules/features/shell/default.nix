{ den, lib, ... }: {
  flake.lib.shell.mkShellrc =
    shell: shellrc:
    lib.lists.flatten shellrc
    |> map (source: if builtins.isFunction source then source shell else source)
    |> lib.concatStringsSep "\n";

  den = {
    quirks.shellrc = "Shell initialization scripts";
    # policies.shellrc =
    #   { user, ... }:
    #   let
    #     inherit (den.lib.policy) pipe;
    #     shellName = user.shell;
    #   in
    #   [
    #     (pipe.from "shellrc" [
    #       (pipe.for lib.lists.flatten)
    #       (pipe.transform (source: if builtins.isFunction source then source shellName else source))
    #     ])
    #   ];

    aspects.shell = {
      includes = with den.aspects; [
        shell.aliases
        shell.input
      ];

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
  };
}
