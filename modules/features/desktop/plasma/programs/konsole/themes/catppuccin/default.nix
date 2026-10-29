{ den, ... }: {
  den.aspects.desktop.plasma.programs.konsole.themes.catppuccin =
    { host, ... }:
    let
      schemePath =
        if host.themes.catppuccin.flavor == "latte" then ./latte.colorscheme else ./mocha.colorscheme;
    in
    {
      includes = [ (den.aspects.desktop.plasma.programs.konsole.color-scheme "catppuccin" schemePath) ];
    };
}
