{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  options = {
    alias.enable = utils.mkEnableOption true "'zed' alias";
  };
  config =
    { self, ... }:
    let
      zedConfigDir = "zed";
    in
    {
      programs.zed-editor =
        let
          objectConfig =
            filepath: override:
            lib.attrsets.recursiveUpdate
              # allow trailing commas + comments
              (utils.fromJSON5 (builtins.readFile filepath))
              override;
          listConfig =
            filepath: override:
            # allow trailing commas + comments
            (utils.fromJSON5 (builtins.readFile filepath)) ++ override;
        in
        {
          enable = true;
          extensions = [
            # themes
            "catppuccin"
            "catppuccin-icons"
            "github-theme"
            "material-icon-theme"
            "colored-zed-icons-theme"
            # extensions
            "git-firefly"
            "nix"
            "dockerfile"
            "docker-compose"
            "log"
            "ssh-config"
            "markdown-oxide"
            "tombi" # toml + lsp
            "neocmake"
            "zig"
            "make"
            "php"
            "sql"
            "java"
          ];
          userSettings = objectConfig ./settings.json (
            with vars.fonts;
            let
              fontZoom = 1.5;
            in
            (utils.ifNotNull { } {
              ui_font_family = normal.name;
              ui_font_size = normal.size * fontZoom;
            } normal)
            // (utils.ifNotNull { } {
              buffer_font_family = monospace.name;
              buffer_font_size = monospace.size * fontZoom;
            } monospace)
          );
          userKeymaps = listConfig ./keymap.json [ ];
        };
      xdg.configFile = {
        "${zedConfigDir}/snippets".source = ./snippets;
      };
      home.shellAliases = if self.alias.enable then { zed = "zeditor"; } else { };
    };
}
