{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.customFonts = {
    pkgs,
    ...
  }: {
    fonts = {
      packages = [
        pkgs.nerd-fonts.iosevka
        self.packages.${pkgs.stdenv.hostPlatform.system}.san-francisco-pro
        self.packages.${pkgs.stdenv.hostPlatform.system}.source-sans-pro
      ];
      fontconfig = {
        enable = true;
        antialias = true;
        defaultFonts = {
          serif = ["Source Sans Pro"];
          sansSerif = ["Source Sans Pro"];
          monospace = ["Iosevka Nerd Font Mono"];
        };
      };
    };
  };
  flake.homeModules.gtk-fonts = {
    pkgs,
    ...
  }: {
    gtk = {
      font = {
        name = "Source Sans Pro";
        size = 12;
      };
    };
  };
  perSystem = {
    config,
    pkgs,
    lib,
    ...
  }: let 
    customFontsDir = builtins.toString inputs.custom-fonts;
  in { 
    packages.futura = pkgs.stdenvNoCC.mkDerivation {
      name = "Futura";
      pname = "futura";
      src = "${customFontsDir}";
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp futura.ttf -t $out/share/fonts/truetype/
      '';
    };
    packages.san-francisco-pro = pkgs.stdenvNoCC.mkDerivation {
      name = "San Francico Pro";
      pname = "san-francisco-pro";
      src = "${customFontsDir}";
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp SF-Pro.ttf -t $out/share/fonts/truetype/
      '';
    };
    packages.source-sans-pro = pkgs.stdenvNoCC.mkDerivation {
      name = "Source Sans Pro";
      pname = "source-sans-pro";
      src = "${customFontsDir}";
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp source-sans-pro.regular.ttf -t $out/share/fonts/truetype/
      '';
    };
    packages.illinois-mono = pkgs.stdenvNoCC.mkDerivation {
      name = "Illinois Mono";
      pname = "illinois-mono";
      src = "${customFontsDir}";
      nativeBuildInputs = [ pkgs.nerd-font-patcher ];
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp IllinoisMono-Regular.ttf -t $out/share/fonts/truetype/

        mkdir -p $out/share/fonts/truetype/{illinois-mono,illinois-mono-nerd}
        mv $out/share/fonts/truetype/*.ttf $out/share/fonts/truetype/illinois-mono/
        for f in $out/share/fonts/truetype/illinois-mono/*.ttf; do
          nerd-font-patcher --complete --variable-width-glyphs --outputdir $out/share/fonts/truetype/illinois-mono-nerd/ $f
          nerd-font-patcher --complete --single-width-glyphs --outputdir $out/share/fonts/truetype/futura-nerd/ $f
        done
      '';
    };
  };
}
