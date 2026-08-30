{ den, ... }: {
  den.aspects.dev.android =
    # https://nixos.org/manual/nixpkgs/unstable/#android
    let
      mkAndroidSdk =
        pkgs:
        let
          androidPkgs = pkgs.androidenv.composeAndroidPackages {
            includeEmulator = "if-supported";
            includeSystemImages = "if-supported";
            includeNDK = "if-supported";
          };
        in
        androidPkgs.androidsdk;
    in
    {
      nixos =
        { user, ... }:
        {
          # https://wiki.nixos.org/wiki/Android
          users.users.${user.userName}.extraGroups = [ "kvm" ];
        };

      sdk = {
        includes = [
          (den.aspects.nixpkgs.settings { android_sdk.accept_license = true; })
          (den.batteries.unfree [
            "android-sdk-cmdline-tools"
            "android-sdk-platform-tools"
            "platform-tools"
            "android-sdk-tools"
            "android-sdk-emulator"
            "android-sdk-system-image-37.1-google_apis-arm64-v8a-system-image-37.1-google_apis-x86_64"
            "system-image-37.1-google_apis-x86_64"
            "system-image-37.1-google_apis-arm64-v8a"
            "android-sdk-system-image-37.1-google_apis_playstore-arm64-v8a-system-image-37.1-google_apis_playstore-x86_64"
            "system-image-37.1-google_apis_playstore-x86_64"
            "system-image-37.1-google_apis_playstore-arm64-v8a"
            "emulator"
            "tools"
            "android-sdk-build-tools"
            "build-tools"
            "android-sdk-platforms"
            "platforms"
            "cmake"
            "android-sdk-ndk"
            "ndk"
            "cmdline-tools"
          ])
        ];

        homeManager =
          { pkgs, ... }:
          let
            androidSdk = mkAndroidSdk pkgs;
          in
          {
            home.packages = [ androidSdk ];
          };
      };

      android-studio = {
        includes = [
          den.aspects.dev.android
          (den.batteries.unfree [ "android-studio" ])
        ];

        homeManager =
          {
            config,
            pkgs,
            host,
            ...
          }:
          {
            home =
              let
                androidSdk = mkAndroidSdk pkgs;
                hasSdk = host.hasAspect den.aspects.dev.android.sdk;
                androidSdkPath =
                  if hasSdk then
                    "${androidSdk}/libexec/android-sdk"
                  else
                    "${config.home.homeDirectory}/.android/sdk"; # manually install here
              in
              {
                packages = if hasSdk then [ (pkgs.android-studio.withSdk androidSdk) ] else [ pkgs.android-studio ];
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
    };
}
