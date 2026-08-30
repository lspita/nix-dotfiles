{ den, lib, ... }: {
  den.aspects.dev.android.android-studio = {
    includes = [ den.aspects.dev.android ];
    homeManager = { config, pkgs, ... }: {
      options.features.dev.android.android-studio = {
        sdk.enable = lib.mkEnableOption "sdk installation";
      };
      config.home =
        let
          cfg = config.features.dev.android.android-studio;
          # https://nixos.org/manual/nixpkgs/unstable/#android
          androidPackages = pkgs.androidenv.composeAndroidPackages {
            includeEmulator = "if-supported";
            includeSystemImages = "if-supported";
            includeNDK = "if-supported";
          };
          androidSdk = androidPackages.androidsdk;
          androidSdkPath =
            if cfg.sdk.enable then
              "${androidSdk}/libexec/android-sdk"
            else
              "${config.home.homeDirectory}/.android/sdk"; # manually install here
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
  };
}
