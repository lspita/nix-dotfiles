{ lib, ... }:
let
  appType = lib.types.submodule (
    { config, ... }: {
      options = {
        exec = lib.mkOption {
          type = lib.types.str;
          description = "Executable name";
        };
        desktop = lib.mkOption {
          type = with lib.types; nullOr str;
          default = "${config.program}.desktop";
          description = "Desktop file name";
        };
      };
    }
  );
in
{
  options.flake.apps = lib.mkOption {
    type = lib.types.attrsOf appType;
    default = { };
    description = "Collection of apps metadata";
  };

  config.den.schema.user.options.apps =
    let
      mkAppOption =
        category:
        lib.mkOption {
          type = lib.types.nullOr appType;
          default = null;
          description = "Default ${category} app";
        };
    in
    {
      terminal = mkAppOption "terminal";
      browser = mkAppOption "browser";
      fileManager = mkAppOption "file manager";
      editor = mkAppOption "editor";
      terminalEditor = mkAppOption "terminal editor";
      music = mkAppOption "music";
      mail = mkAppOption "mail";
      pdf = mkAppOption "pdf viewer";
      image = mkAppOption "image viewer";
      audio = mkAppOption "audio player";
      video = mkAppOption "video player";
    };
}
