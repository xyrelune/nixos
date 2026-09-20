{
  self,
  inputs,
  ...
}: {
  flake.homeModules.alacritty = {
    pkgs,
    ...
  }: {
    programs.alacritty = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myAlacritty;
    };
  };
  perSystem = {
    pkgs,
    ...
  }: {
    packages.myAlacritty = inputs.wrapper-modules.wrappers.alacritty.wrap {
      inherit pkgs;
      settings = {
        font = {
          size = 12;
        };
        window = {
          opacity = 1;
        };
        colors = {
          primary = {
            background = "#282828";
            foreground = "#ebdbb2";
          };
        
          cursor = {
            text = "#282828";
            cursor = "#ebdbb2";
          };
        
          vi_mode_cursor = {
            text = "#282828";
            cursor = "#ebdbb2";
          };
        
          selection = {
            text = "#ebdbb2";
            background = "#504945";
          };
        
          normal = {
            black = "#282828";
            red = "#cc241d";
            green = "#98971a";
            yellow = "#d79921";
            blue = "#458588";
            magenta = "#b16286";
            cyan = "#689d6a";
            white = "#a89984";
          };
        
          bright = {
            black = "#928374";
            red = "#fb4934";
            green = "#b8bb26";
            yellow = "#fabd2f";
            blue = "#83a598";
            magenta = "#d3869b";
            cyan = "#8ec07c";
            white = "#ebdbb2";
          };
        
          hints = {
            start = {
              foreground = "#282828";
              background = "#fabd2f";
            };
        
            end = {
              foreground = "#928374";
              background = "#282828";
            };
          };
        };
      };
    };
  };
}
