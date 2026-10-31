{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.pipewire = {
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = [
      pkgs.playerctl 
    ];
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      extraConfig = {
        pipewire = {
          "65-hires-audio.conf" = {
            "context.properties" = {
              "default.clock.rate" = "44100";
              "default.clock.allowed.rates" = [ "44100" ];
              "default.clock.quantum" = "1024";
              "default.clock.max-quantum" = "8192";
              "default.clock.min-quantum" = "32";
            };
          };
        }; 
        pipewire-pulse = {
          "92-low-latency" = {
            "pulse.properties" = {
              "pulse.default.format" = "F32";
            };
            "stream.properties" = {
              "resample.quality" = "15";
              "channel.normalize" = "false";
              "channel.upmix" = "false";
              "channel.upmix-method" = "none";
              "channel.mix-life" = "false";
            };
          };
        };
      };

#      extraConfig = {
#        pipewire = {
#          "50-bitperfect-dac.conf" = {
#            "context.objects" = [
#              {
#                "factory" = "adapter";
#                "args" = {
#                  "factory.name" = "api.alsa.pcm.sink";
#                  "node.name" = "DAC_Bit_Perfect";
#                  "node.description" = "USB DAC (Bit-Perfect Mode)";
#                  "media.class" = "Audio/Sink";
#                  "api.alsa.path" = "hw:Pro";
#                  "api.alsa.period-alsa" = "1024";
#                  "api.alsa.headroom" = "0";
#                  "audio.format" = "S32LE";
#                  "audio.channels" = "2";
#                  "node.suspend-on-idle" = "false";
#                  "priority.driver" = "9000";
#                  "priority.session" = "9000";
#                  "resample.disable" = "true";
#                  "monitor.channel-volumes" = "false";
#                };
#              }
#            ];
#            "context.properties" = {
#              "default.clock.rate" = "44100";
#              "default.clock.allowed-rates" = ["44100"];
#              "default.clock.quantum" = "1024";
#              "default.clock.max-quantum" = "8192";
#              "default.clock.min-quantum" = "32";
#            };
#          };
#        };
#      };
    };
  };
}
