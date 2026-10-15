{
  den,
  lib,
  lib2,
  ...
}:
{
  meta.fonts =
    (
      lib2.fonts.mkNerdFontMetaCollection {
        noto-sans = "NotoSans";
        noto-sans-m = "NotoSansM";
        noto-serif = "NotoSerif";
        noto-serif-m = "NotoSerifM";
        noto-mono = "NotoMono";
      }
      |> lib.filterAttrs (
        id: _:
        !builtins.elem id [
          "noto-sans-nf-mono"
          "noto-serif-nf-mono"
        ]
      )
    )
    // (lib2.fonts.mkFontMetaCollection {
      noto-sans = "Noto Sans";
      noto-serif = "Noto Serif";
    });

  den.aspects.fonts = {
    noto = den.aspects.font (p: [ p.noto-fonts ]);
    noto-nf = den.aspects.font (p: [ p.nerd-fonts.noto ]);
  };
}
