{
  ...
}: {
  flake.homeModules.waybar = {
    ...
  }: {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 23;
          spacing = 5;
          modules-left = ["niri/workspaces" "mpris" ];
          modules-center = [];
          modules-right = ["tray" "custom/seperator" "cpu" "custom/seperator" "memory" "custom/seperator" "battery" "custom/seperator" "clock#date" "custom/seperator" "clock#time"];
          "cpu" = {
            interval = 10;
            format = "󰻠 {usage}%";
          };
          "memory" = {
            interval = 30;
            format = "󰍛 {}%";
          };
          "battery" = {
            format = "󰁹 {capacity}%";
          };
          "clock#date" = {
            format = "󰃭 {:%d/%m(%a)}";
          };
          "clock#time" = {
            format = "󰅐 {:%I:%M %p} ";
            interval = 1;
          };
          "custom/seperator" = {
            format = "|";
            tooltip = false;
          };
          "mpris" = {
            format = "{player_icon} {title}";
            format-paused = "{status_icon} {title}";
            player-icons =  {
              default = "";
              spotify = "";
              firefox = "󰈹";
              chromium = "";
            };
            status-icons = {
              paused =  "";
            };
            interval = 1;
          };
          "tray" = {
            spacing = 5;
          };
        };
      };
      style = "
        #waybar {
            font-family: 'Source Sans Pro' , 'Iosevka Nerd Font Propo';
            font-size: 15px;
            font-weight: normal;
            background-color: rgba(31, 31, 40, 0.7);
        }
        
        #cpu {
            color: #938aa9;
        }
        
        #memory {
            color: #98bb6c;
        }
        
        #battery {
            color: #e6c384;
        }
        
        #clock.date {
            color: #ffa066;
        }
        
        #clock.time {
            color: #e82424;
        }
        
        #window {
            color: #727169;
        }
        
        #workspaces button {
            all: initial;
            color: #727169;
            padding: 0 8px;
            margin: 0;
        }
        
        #workspaces button.active {
            color: #7e9cd8;
        }
        
        #workspaces button:hover {
            color: #dcd7ba;
        }
        
        #custom-seperator {
            color: #54546d;
            padding: 0px;
        }
      ";
    };
  };
}
