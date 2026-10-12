{ lib, ... }:
let
  programType = lib.types.submodule (
    { config, ... }: {
      options = {
        exec = lib.mkOption {
          type = lib.types.str;
          description = "Executable name";
        };
        desktop = lib.mkOption {
          type = with lib.types; nullOr str;
          default = "${config.exec}.desktop";
          description = "Desktop file name";
        };
      };
    }
  );
in
{
  options.flake.programs = lib.mkOption {
    type = lib.types.attrsOf programType;
    default = { };
    description = "Collection of programs metadata";
  };

  config.den.schema.host.options.programs =
    let
      mkProgramOption =
        category:
        lib.mkOption {
          type = lib.types.nullOr programType;
          default = null;
          description = "Default ${category} app";
        };
    in
    {
      terminal = mkProgramOption "terminal";
      browser = mkProgramOption "browser";
      fileManager = mkProgramOption "file manager";
      editor = mkProgramOption "editor";
      terminalEditor = mkProgramOption "terminal editor";
      music = mkProgramOption "music";
      mail = mkProgramOption "mail";
      pdf = mkProgramOption "pdf viewer";
      image = mkProgramOption "image viewer";
      audio = mkProgramOption "audio player";
      video = mkProgramOption "video player";
    };
}
