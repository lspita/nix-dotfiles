{
  den.aspects.nix = {
    os = { host, ... }: {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nixpkgs.config = {
        allowUnfree = true;
        android_sdk.accept_license = true;
        cudaSupport = host.graphics == "nvidia";
        permittedInsecurePackages = [
          "electron-39.8.10"
        ];
      };
    };
  };
}
