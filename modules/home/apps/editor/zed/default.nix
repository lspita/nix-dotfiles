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
          "toml"
          "neocmake"
          "zig"
          "make"
        ];
        userSettings = objectConfig ./settings.json (
          let
            normalFont = vars.fonts.normal;
            monoFont = vars.fonts.monospace;
            fontZoom = 1.5;
          in
          {
            ui_font_family = normalFont.name;
            ui_font_size = normalFont.size * fontZoom;
            buffer_font_family = monoFont.name;
            buffer_font_size = monoFont.size * fontZoom;
          }
        );
        userKeymaps = listConfig ./keymap.json [ ];
      };
    home.shellAliases.zed = "zeditor";
  };
}
