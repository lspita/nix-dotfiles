{
  den.aspects.nixpkgs = {
    os = { host, ... }: {
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
