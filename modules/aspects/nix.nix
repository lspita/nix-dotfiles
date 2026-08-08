{
  den.aspects.nix = {
    os = {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
