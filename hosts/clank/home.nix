{ ... }:
{
  custom = {
    core.enableDefaults = true;
    linux = {
      core.enableDefaults = true;
      desktop.gnome = {
        enableDefaults = true;
        settings = {
          vrr.enable = true;
          fractionalScaling.enable = true;
          locationServices.enable = true;
        };
        extensions.blur-my-shell.applications.enable = true;
      };
    };
    security.bitwarden = {
      enable = true;
      sshAgent.enable = true;
    };
    shell = {
      enableDefaults = true;
      prompt.starship = {
        enable = true;
        preset = "omarchy";
      };
      zsh.enable = true;
      bash = {
        enable = true;
        blesh.enable = true;
      };
    };
    terminal.gnome-console.enable = true;
    editor = {
      zed.enable = true;
      vscode.enable = true;
    };
    browser = {
      firefox = {
        enable = true;
        passwordManager.enable = false;
      };
      chrome.enable = true;
    };
    spotify.enable = true;
    gh.enable = true;
    fastfetch.enable = true;
  };
}
