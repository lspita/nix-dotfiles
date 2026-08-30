{
  den.aspects.tools.probe-rs.nixos =
    { user, pkgs, ... }:
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
    {
      users.groups.${plugdevGroup} = { };
      users.users.${user.userName}.extraGroups = [ plugdevGroup ];
      services.udev.packages = [ probersUdevRulesPackage ];
    };
}
