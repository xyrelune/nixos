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
          height = 20;
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
            font-family: 'JetBrainsMono Nerd Font Propo';
            font-size: 14px;
            font-weight: normal;
            background-color: rgba(26, 27, 38, 1);
        }
        
        #cpu {
            color: #bb9af7;
        }
        
        #memory {
            color: #9ece6a;
        }
        
        #battery {
            color: #e0af68;
        }
        
        #clock.date {
            color: #ff9e64;
        }
        
        #clock.time {
            color: #f7768e;
        }
        
        #window {
            color: #565f89;
        }
        
        #workspaces button {
            all: initial;
            color: #565f89;
            padding: 0 8px;
            margin: 0;
        }
        
        #workspaces button.active {
            color: #7aa2f7;
        }
        
        #workspaces button:hover {
            color: #c0caf5;
        }
        
        #custom-seperator {
            color: #414868;
            padding: 0;
        }
      ";
    };
  };
}
