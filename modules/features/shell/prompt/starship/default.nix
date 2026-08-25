{ den, ... }: {
  den.aspects.shell.prompt.starship = {
    includes = with den.aspects.shell.prompt.starship; [
      presets.omarchy
    ];

    homeManager.programs.starship = {
      enable = true;
    };

    presets =
      let
        mkPresetAspect = preset: {
          homeManager.programs.starship.settings = fromTOML (builtins.readFile ./presets/${preset}.toml);
        };
      in
      {
        omarchy = mkPresetAspect "omarchy";
        jetpack = mkPresetAspect "jetpack";
      };
  };
}
