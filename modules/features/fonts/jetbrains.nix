{ den, lib2, ... }: {
  meta.fonts = lib2.fonts.mkNerdFontMetaCollection {
    jetbrains-mono = "JetBrainsMono";
    jetbrains-mono-nl = "JetBrainsMonoNL";
  };

  den.aspects.fonts.jetbrains-mono-nf = den.aspects.font (p: [ p.nerd-fonts.jetbrains-mono ]);
}
