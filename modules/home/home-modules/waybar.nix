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
          height = 25;
          spacing = 15;
          modules-left = ["niri/workspaces" ];
          modules-center = [];
          modules-right = ["tray" "custom/seperator" "cpu" "memory" "battery"  "clock#date" "clock#time"];
          "cpu" = {
            interval = 10;
            format = "Cpu:{usage}%";
          };
          "memory" = {
            interval = 30;
            format = "Ram:{}%";
          };
          "battery" = {
            format = "Bat:{capacity}%";
          };
          "clock#date" = {
            format = "{:%a %d/%m}";
          };
          "clock#time" = {
            format = "{:%I:%M %p} ";
            interval = 1;
          };
          "custom/seperator" = {
            format = "|";
            tooltip = false;
          };
          "tray" = {
            spacing = 5;
          };
        };
      };
      style = "
        #waybar {
            font-family: 'Iosevka Nerd Font Propo';
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
