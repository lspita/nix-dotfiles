{ den, lib2, ... }: {
  meta.fonts = lib2.fonts.mkNerdFontMetaCollection {
    fira-code = "FiraCode";
    fira-mono = "FiraMono";
  };

  den.aspects.fonts = {
    fira-code-nf = den.aspects.font (p: [ p.nerd-fonts.fira-code ]);
    fira-mono-nf = den.aspects.font (p: [ p.nerd-fonts.fira-mono ]);
  };
}
