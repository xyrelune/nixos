{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.foot = {
    pkgs,
    lib,
    ...
  }: {
    programs.foot = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myFoot;
    };
  };
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.myFoot = inputs.wrapper-modules.wrappers.foot.wrap {
      inherit pkgs;
      settings = {
        main = {
          font = "Iosevka Nerd Font Mono:size=12";
        };
        colors-dark = {
          alpha = "1";
          blur = "no";
          background = "1f1f28";
          foreground = "dcd7ba";
          
          regular0 = "090618";
          regular1 = "c34043";
          regular2 = "76946a";
          regular3 = "c0a36e";
          regular4 = "7e9cd8";
          regular5 = "957fb8";
          regular6 = "6a9589";
          regular7 = "c8c093";
          
          bright0 = "727169";
          bright1 = "e82424";
          bright2 = "98bb6c";
          bright3 = "e6c384";
          bright4 = "7fb4ca";
          bright5 = "938aa9";
          bright6 = "7aa89f";
          bright7 = "dcd7ba";

          selection-background = "504945";
          selection-foreground = "ebdbb2";

          urls = "83a598";
        };
      };
    };
  };
}
