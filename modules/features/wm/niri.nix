{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.niri = {
    pkgs,
    lib,
    ...
  }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };
  perSystem = {
    config,
    pkgs,
    lib,
    ...
  }: let 
    wallspath = builtins.toString inputs.walls;
  in {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        hotkey-overlay = {
          skip-at-startup = _: {};
        };
        prefer-no-csd = _: {};
        input = {
          mod-key = "Alt";
          keyboard = {
            xkb.layout = "us";
          };
          touchpad = {
            #off = _: {};
            tap = _: {};
            natural-scroll = _: {};
            accel-speed = 0.2;
          };
          mouse = {
            accel-speed = 0;
          };
        };
        layout = {
          gaps = 0.5;
          center-focused-column = "never";
          focus-ring = {
            active-color = "#7e9cd8";
            inactive-color = "#54546d";
            width = 0.5;
          };
        };
        outputs = {
          "eDP-1" = {
            # off = _: {};
            mode = "1920x1080@165.002";
            scale = 1;
            position = _: {
              props = {
                x = 0;
                y = 1080;
              };
            };
          };
          "eDP-2" = {
            off = _: {};
            mode = "1920x1080@165.000";
            scale = 1;
            position = _: {
              props = {
                x = 0;
                y = 1080;
              };
            };
          };
          "HDMI-A-1" = {
            off = _: {};
            mode = "3840x2160@143.988";
            scale = 2;
            position = _: {
              props = {
                x = 0;
                y = 0;
              };
            };
          };
        };
        window-rules = [
          {
            matches = [
              {app-id = "firefox";}
              {app-id = "helium";}
              {app-id = "brave-origin";}
              {app-id = "spotify";}
              {app-id = "Spotify";}
              {app-id = "equibop";}
              {app-id = "discord";}
              {app-id = "zen-beta";}
              {app-id = "tidal-hifi";}
              {app-id = "chromium-browser";}
              {app-id = "io.github.tdesktop_x64.TDesktop";}
            ];
            open-maximized = true;
          }
          {
            matches = [
              { 
                app-id = "firefox$";
                title = "^Picture-in-Picture$";
              }
              {
                title = "Picture in picture";
              }
            ];
            open-floating = true;
            default-column-width = [ { fixed = 480; } ];
            default-window-height = [ { fixed = 270; } ];
          }
        ];
        layer-rules = [
          {
            matches = [
              {namespace = "^launcher$";}
            ];
            background-effect = {
              blur = false;
            };
          }
        ];
        binds = {
          "Mod+Return".spawn-sh = "foot";
          "Mod+D".spawn-sh = "fuzzel";
          "Mod+B".spawn-sh = "firefox";
          "Mod+P".spawn-sh = "spotify";
          "Mod+U".spawn-sh = "emacsclient -c";

          "Mod+F".maximize-column = _: {};
          "Mod+Shift+F".fullscreen-window = _: {};

          "Mod+Space".toggle-overview = _: {};
          "Mod+Q".close-window = _: {};

          "Mod+BracketLeft".consume-or-expel-window-left = _: {};
          "Mod+BracketRight".consume-or-expel-window-right = _: {};

          "Mod+H".focus-column-left = _: {};
          "Mod+J".focus-window-down = _: {};
          "Mod+K".focus-window-up = _: {};
          "Mod+L".focus-column-right = _: {};

          "Mod+Ctrl+H".move-column-left = _: {};
          "Mod+Ctrl+J".move-window-down = _: {};
          "Mod+Ctrl+K".move-window-up = _: {};
          "Mod+Ctrl+L".move-column-right = _: {};

          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          "Mod+Ctrl+1".move-column-to-workspace = 1;
          "Mod+Ctrl+2".move-column-to-workspace = 2;
          "Mod+Ctrl+3".move-column-to-workspace = 3;
          "Mod+Ctrl+4".move-column-to-workspace = 4;
          "Mod+Ctrl+5".move-column-to-workspace = 5;
          "Mod+Ctrl+6".move-column-to-workspace = 6;
          "Mod+Ctrl+7".move-column-to-workspace = 7;
          "Mod+Ctrl+8".move-column-to-workspace = 8;
          "Mod+Ctrl+9".move-column-to-workspace = 9;

          "Mod+Shift+H".focus-monitor-left = _: {};
          "Mod+Shift+J".focus-monitor-down = _: {};
          "Mod+Shift+K".focus-monitor-up = _: {};
          "Mod+Shift+L".focus-monitor-right = _: {};

          "Mod+Shift+Ctrl+H".move-column-to-monitor-left = _: {};
          "Mod+Shift+Ctrl+J".move-column-to-monitor-down = _: {};
          "Mod+Shift+Ctrl+K".move-column-to-monitor-up = _: {};
          "Mod+Shift+Ctrl+L".move-column-to-monitor-right = _: {};

          "Mod+WheelScrollDown".focus-workspace-down = _: {};
          "Mod+WheelScrollUp".focus-workspace-up = _: {};
          "Mod+Ctrl+WheelScrollDown".move-column-to-workspace-down = _: {};
          "Mod+Ctrl+WheelScrollUp".move-column-to-workspace-up = _: {};
          "Mod+Shift+WheelScrollDown".focus-column-left = _: {};
          "Mod+Shift+WheelScrollUp".focus-column-right = _: {};

          "Mod+C".center-column = _: {};
          "Mod+V".toggle-window-floating = _: {};
          "Mod+Shift+V".switch-focus-between-floating-and-tiling = _: {};
          "Mod+W".toggle-column-tabbed-display = _: {};
          "Print".screenshot = _: {};
          "Ctrl+Print".screenshot-screen = _: {};
          "Mod+Print".screenshot-window = _: {};
          "Mod+Escape".toggle-keyboard-shortcuts-inhibit = _: {};

          "Mod+Shift+E".quit = _: {};

          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";
          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";
          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
          "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "Mod+M".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86MonBrightnessUp".spawn-sh = "${lib.getExe pkgs.brightnessctl} -c backlight s 10%+";
          "XF86MonBrightnessDown".spawn-sh = "${lib.getExe pkgs.brightnessctl} -c backlight s 10%-";


          "Mod+F2".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "Mod+F3".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
          "Mod+F4".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0";
          "Mod+F6".spawn-sh = "${lib.getExe pkgs.brightnessctl} -c backlight s 10%+";
          "Mod+F5".spawn-sh = "${lib.getExe pkgs.brightnessctl} -c backlight s 10%-";

          "Mod+T".spawn-sh = ''notify-send "Current Time" "$(date +"%I:%M %p")"'';
          "Mod+Shift+P".spawn-sh = "niri msg action power-off-monitors";
          "Mod+e".spawn-sh = ''${lib.getExe pkgs.cliphist} list | ${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myFuzzel} --dmenu | ${lib.getExe pkgs.cliphist} decode | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}'';
          "Mod+Shift+I".spawn-sh = "rofi-rbw --clear-after 30";
          "Mod+Shift+T".spawn-sh = "rofi-rbw --action type --target totp --clear-after 30"; 
        };
        spawn-sh-at-startup = [
          "${lib.getExe pkgs.swaybg} -i ${wallspath}/dune.jpg"
          "waybar"
        ];
      };
    };
  };
}
