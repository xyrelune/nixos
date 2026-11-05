{
  self,
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.foot = moduleWithSystem ({
    pkgs,
    lib,
    self',
    ...
  }: {
    programs.foot = {
      enable = true;
      package = self'.packages.myFoot;
    };
  });
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
          
          foreground = "ebdbb2";
          background = "282828";
          
          selection-foreground = "ebdbb2";
          selection-background = "504945";
          
          urls = "83a598";
          
          regular0 = "282828";
          regular1 = "cc241d";
          regular2 = "98971a";
          regular3 = "d79921";
          regular4 = "458588";
          regular5 = "b16286";
          regular6 = "689d6a";
          regular7 = "a89984";
          
          bright0 = "928374";
          bright1 = "fb4934";
          bright2 = "b8bb26";
          bright3 = "fabd2f";
          bright4 = "83a598";
          bright5 = "d3869b";
          bright6 = "8ec07c";
          bright7 = "ebdbb2";
        };
      };
    };
  };
}
