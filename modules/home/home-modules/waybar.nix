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
            font-family: 'Roboto', 'RobotoMono Nerd Font Propo';
            font-size: 16px;
            font-weight: normal;
            background-color: rgba(40, 40, 40, 1);
        }
        
        #cpu {
            color: #d79921;
        }
        
        #memory {
            color: #98971a;
        }
        
        #battery {
            color: #d65d0e;
        }
        
        #clock.date {
            color: #fe8019;
        }
        
        #clock.time {
            color: #fb4934;
        }
        
        #window {
            color: #928374;
        }
        
        #workspaces button {
            all: initial;
            color: #928374;
            padding: 0 8px;
            margin: 0;
        }
        
        #workspaces button.active {
            color: #83a598;
        }
        
        #workspaces button:hover {
            color: #ebdbb2;
        }
        
        #custom-seperator {
            color: #665c54;
            padding: 0;
        }
      ";
    };
  };
}
