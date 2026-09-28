{ den, ... }: {
  den.aspects.fonts = {
    noto = den.aspects.font (p: [ p.noto-fonts ]);
    noto-nf = den.aspects.font (p: [ p.nerd-fonts.noto ]);
  };
}
