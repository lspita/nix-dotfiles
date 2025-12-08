{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  config = {
    programs.zed-editor =
      let
        objectConfig =
          path: override: lib.attrsets.recursiveUpdate (builtins.fromJSON (builtins.readFile path)) override;
        listConfig = path: override: builtins.fromJSON (builtins.readFile path) ++ override;
      in
      {
        enable = true;
        extensions = [
          "catppuccin"
          "catppuccin-icons"
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
    home.shellAliases.zed = "zeditor";
  };
}
