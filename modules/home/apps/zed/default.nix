{
  options,
  lib,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  options = {
    package.enable = modules.mkEnableOption true "zed package installation";
    alias.enable = modules.mkEnableOption true "'zed' alias";
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
              (files.fromJSON5 (builtins.readFile filepath))
              override;
          listConfig =
            filepath: override:
            # allow trailing commas + comments
            (files.fromJSON5 (builtins.readFile filepath)) ++ override;
        in
        {
          enable = true;
          package = if self.package.enable then options.programs.zed-editor.package.default else null;
          extensions = [
            # themes
            "catppuccin"
            "catppuccin-icons"
            "github-theme"
            "material-icon-theme"
            "colored-zed-icons-theme"
            # extensions
            "html"
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
            "lua"
            "kotlin"
          ];
          userSettings = objectConfig ./settings.json (
            with vars.fonts;
            let
              fontZoom = 1.5;
            in
            (optionals.ifNotNull { } {
              ui_font_family = normal.name;
              ui_font_size = normal.size * fontZoom;
            } normal)
            // (optionals.ifNotNull { } {
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
