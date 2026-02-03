{
  lib,
  flakeInputs,
  pkgs,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  imports = [ flakeInputs.plasma-manager.homeModules.plasma-manager ];
  options = {
    defaultProfile = {
      name = lib.mkOption {
        type = with lib.types; str;
        default = "default";
        description = "The default profile name.";
      };
      colorScheme = lib.mkOption {
        type = with lib.types; str;
        default = "catppuccin-mocha";
        description = "The default color scheme to use.";
      };
    };
  };
  config =
    { self, ... }:
    {
      home.packages = with pkgs.kdePackages; [ konsole ];
      programs.konsole =
        let
          defaultProfileName = self.defaultProfile.name;
          colorSchemes =
            let
              colorSchemesRoot = ./colorSchemes;
            in
            builtins.foldl'
              (
                result: p:
                result
                // {
                  ${builtins.head (lib.strings.splitString "." p)} = lib.path.append colorSchemesRoot p;
                }
              )
              { }
              (
                builtins.attrNames (
                  lib.attrsets.filterAttrs (_: type: type == "regular") (builtins.readDir colorSchemesRoot)
                )
              );
        in
        {
          enable = true; # enables only the configuration, does not ensure the package is installed
          customColorSchemes = colorSchemes;
          profiles =
            let
              defaultProfile = {
                inherit (self.defaultProfile) colorScheme;
              };
            in
            with lib.attrsets;
            recursiveUpdate
              {
                ${defaultProfileName} = defaultProfile;
              }
              (
                builtins.mapAttrs (
                  name: _:
                  recursiveUpdate defaultProfile {
                    colorScheme = name;
                  }
                ) colorSchemes
              );
          defaultProfile = defaultProfileName;
        };
    };
}
