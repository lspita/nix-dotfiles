{
  config,
  customLib,
  pkgs,
  vars,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "nixos"
    "desktop"
    "gnome"
  ];
  mkConfig =
    { ... }:
    {
      services.desktopManager.gnome.enable = true;
      environment.gnome.excludePackages = with pkgs; [
        gnome-contacts
        gnome-tour
        geary
        epiphany
      ];
      # https://github.com/Stunkymonkey/nautilus-open-any-terminal
      programs.nautilus-open-any-terminal = {
        enable = true;
        terminal = "custom";
      };
      # programs.dconf.profiles.user.databases = [
      #   {
      #     settings."com.github.stunkymonkey.nautilus-open-any-terminal" = {
      #       terminal = vars.linux.defaultApps.terminal.program;
      #     };
      #   }
      # ];
    };
}
