{
  self,
  inputs,
  ...
}: {
  flake.homeModules.easyeffects = {
    services.easyeffects = {
      enable = true;
      preset = "my-preset";
      extraPresets = {
        my-preset = {
          input = {
            blocklist = [];
            "rnnoise#0" = {
              bypass = false;
              enable-vad = false;
              input-gain = 0.0;
              model-name = "\\";
              output-gain = 0.0;
              release = 20.0;
              use-standard-model = true;
              vad-thres = 30.0;
              wet = 0.0;
            };
            plugins_order = [
              "rnnoise#0"
            ];
          };
        };
      };
    };
  };
}
