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
            background = "#1a1b26";
            foreground = "#c0caf5";
          };
          
          cursor = {
            text = "#1a1b26";
            cursor = "#c0caf5";
          };
          
          vi_mode_cursor = {
            text = "#1a1b26";
            cursor = "#c0caf5";
          };
          
          selection = {
            text = "#c0caf5";
            background = "#283457";
          };
          
          normal = {
            black = "#15161e";
            red = "#f7768e";
            green = "#9ece6a";
            yellow = "#e0af68";
            blue = "#7aa2f7";
            magenta = "#bb9af7";
            cyan = "#7dcfff";
            white = "#a9b1d6";
          };
          
          bright = {
            black = "#414868";
            red = "#f7768e";
            green = "#9ece6a";
            yellow = "#e0af68";
            blue = "#7aa2f7";
            magenta = "#bb9af7";
            cyan = "#7dcfff";
            white = "#c0caf5";
          };
          
          hints = {
            start = {
              foreground = "#a9b1d6";
              background = "#1a1b26";
            };
            
            end = {
              foreground = "#414868";
              background = "#1a1b26";
            };
          };
        };
      };
    };
  };
}
