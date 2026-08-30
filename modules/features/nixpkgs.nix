{
  den.aspects.nixpkgs.settings = config: {
    os.nixpkgs = { inherit config; };
    homeManager =
      {
        osConfig ? { },
        ...
      }:
      if osConfig.home-manager.useGlobalPkgs or false then { } else { nixpkgs = { inherit config; }; };
  };
}
