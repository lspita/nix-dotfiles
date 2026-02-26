{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  config =
    let
      probersUdevRulesPackage = pkgs.stdenv.mkDerivation {
        name = "probe-rs-rules";
        src = ./.;
        installPhase = ''
          mkdir -p $out/lib/udev/rules.d
          cp 69-probe-rs.rules $out/lib/udev/rules.d/
        '';
      };
      plugdevGroup = "plugdev";
    in
    platform.systemTypeValue {
      linux = {
        users.groups.${plugdevGroup} = { };
        users.users.${vars.user.username}.extraGroups = [ plugdevGroup ];
        services.udev.packages = [ probersUdevRulesPackage ];
      };
      darwin = { };
    };
}
