{ lib, ... }: {
  den.aspects.nix.nixpkgs =
    options:
    let
      nixpkgs = lib.attrsets.recursiveUpdate {
        config = { };
        overlays = [ ];
      } options;
      config = { inherit nixpkgs; };
    in
    {
      os = config;
      homeManager =
        {
          osConfig ? null,
          ...
        }:
        if (!isNull osConfig) && (osConfig.home-manager.useGlobalPkgs) then { } else config;
    };
}
