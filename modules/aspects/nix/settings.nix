{
  nix.settings = {
    os = {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
