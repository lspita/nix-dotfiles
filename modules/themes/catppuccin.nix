{ lib, ... }: {
  den.schema.host.options.themes.catppuccin = {
    flavor = lib.mkOption {
      type = lib.types.enum [
        "mocha"
        "latte"
        "frappe"
        "macchiato"
      ];
      default = "mocha";
      description = "Cattpuccin flavor";
    };
    accent = lib.mkOption {
      type = lib.types.enum [
        "blue"
        "flamingo"
        "green"
        "lavender"
        "maroon"
        "mauve"
        "peach"
        "pink"
        "red"
        "rosewater"
        "sapphire"
        "sky"
        "teal"
        "yellow"
      ];
      default = "mauve";
      description = "Cattpuccin accent";
    };
  };
}
