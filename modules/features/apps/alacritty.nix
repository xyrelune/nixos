{
  self,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    ...
  }: {
    packages.myAlacritty = inputs.wrapper-modules.wrappers.alacritty.wrap {
      inherit pkgs;
      settings = {
        font = {
          size = 12.0;
          normal = {
            family = "Iosevka Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "Iosevka Nerd Font";
            style = "Bold";
          };
        };
   
        cursor = {
          style = {
            shape = "Beam";
            blinking = "On";
          };
          blink_interval = 600;
        };
   
        scrolling.history = 10000;
   
        colors = {
          primary = {
            background = "#282828";
            foreground = "#ebdbb2";
            bright_foreground = "#fbf1c7";
          };
   
          cursor = {
            text = "CellBackground";
            cursor = "#fabd2f";
          };
   
          selection = {
            text = "CellBackground";
            background = "#665c54";
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
   
          dim = {
            black = "#32302f";
            red = "#9d0006";
            green = "#79740e";
            yellow = "#b57614";
            blue = "#076678";
            magenta = "#8f3f71";
            cyan = "#427b58";
            white = "#928374";
          };
        };
      };
    };
  };
}
