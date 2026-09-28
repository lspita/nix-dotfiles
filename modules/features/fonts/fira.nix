{ den, ... }: {
  den.aspects.fonts = {
    fira-code-nf = den.aspects.font (p: [ p.nerd-fonts.fira-code ]);
    fira-mono-nf = den.aspects.font (p: [ p.nerd-fonts.fira-mono ]);
  };
}
