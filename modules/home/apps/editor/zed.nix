{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./zed.nix {
  config = {
    programs.zed-editor = {
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
      ];
      userSettings =
        let
          normalFont = vars.fonts.normal;
          monoFont = vars.fonts.monospace;
          fontZoom = 1.5;
        in
        {
          tabs = {
            git_status = true;
          };
          title_bar = {
            show_branch_icon = true;
          };
          middle_click_paste = false;
          show_signature_help_after_edits = true;
          terminal = {
            blinking = "on";
          };
          project_panel = {
            hide_root = true;
            dock = "right";
          };
          base_keymap = "VSCode";
          linked_edits = true;
          show_whitespaces = "selection";
          show_edit_predictions = true;
          agent = {
            dock = "left";
          };
          auto_signature_help = true;
          minimap = {
            show = "always";
          };
          inlay_hints = {
            enabled = true;
          };
          telemetry = {
            diagnostics = false;
            metrics = false;
          };
          theme = {
            mode = "system";
            dark = "Catppuccin Mocha";
            light = "Catppuccin Latte";
          };
          icon_theme = {
            mode = "system";
            dark = "Catppuccin Mocha";
            light = "Catppuccin Latte";
          };
          ui_font_family = normalFont.name;
          ui_font_size = normalFont.size * fontZoom;
          ui_font_features = {
            calt = false;
          };
          buffer_font_family = monoFont.name;
          buffer_font_size = monoFont.size * fontZoom;
          buffer_font_features = {
            calt = false;
          };
          file_types = {
            "Shell Script" = [
              ".envrc"
            ];
          };
        };
      userKeymaps = [
        {
          context = "ProjectPanel";
          bindings = {
            ctrl-shift-n = "project_panel::NewDirectory";
          };
        }
        {
          context = "Workspace";
          bindings = {
            ctrl-alt-n = "workspace::NewWindow";
          };
        }
        {
          context = "Workspace || Editor";
          bindings = {
            "ctrl-;" = "terminal_panel::Toggle";
          };
        }
        {
          context = "Workspace";
          bindings = {
            ctrl-alt-b = "workspace::ToggleLeftDock";
          };
        }
        {
          context = "Workspace";
          bindings = {
            ctrl-b = "workspace::ToggleRightDock";
          };
        }
        {
          context = "Workspace";
          bindings = {
            ctrl-r = [
              "projects::OpenRecent"
              {
                create_new_window = false;
              }
            ];
          };
        }
      ];
    };
    home.shellAliases.zed = "zeditor";
  };
}
