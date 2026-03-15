{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./android-studio.nix {
  options = {
    sdk = {
      enable = modules.mkEnableOption false "android sdk";
      numLatestPlatformVersions = lib.mkOption {
        type = with lib.types; ints.positive;
        default = 1;
        description = "Number of years of platform versions to support.";
      };
    };
  };
  config =
    { self, ... }:
    {
      home =
        let
          # https://nixos.org/manual/nixpkgs/unstable/#android
          androidPackages = pkgs.androidenv.composeAndroidPackages {
            inherit (self.sdk) numLatestPlatformVersions;
            includeEmulator = "if-supported";
            includeSystemImages = "if-supported";
            includeNDK = "if-supported";
          };
          androidSdk = androidPackages.androidsdk;
          androidSdkPath =
            if self.sdk.enable then
              "${androidSdk}/libexec/android-sdk"
            else
              "${dotfiles.homeDir inputs}/.android/sdk"; # manually install here
        in
        {
          packages =
            with pkgs;
            if self.sdk.enable then
              [
                androidSdk
                (android-studio.withSdk androidSdk)
              ]
            else
              [ android-studio ];
          sessionVariables = {
            ANDROID_HOME = androidSdkPath;
            ANDROID_SDK_ROOT = androidSdkPath;
            ANDROID_NDK_ROOT = "${androidSdkPath}/ndk-bundle";
          };
          sessionPath = [
            # https://developer.android.com/tools
            "${androidSdkPath}/tools"
            "${androidSdkPath}/tools/bin"
            "${androidSdkPath}/platform-tools"
          ];
        };
    };
}
