{
  self,
  input,
  ...
}: {
  flake.nixosModules.arr = {
    services = {
      radarr = {
        enable = true;
        user = "media";
        group = "media";
        settings = {
          server = {
            port = 7878;
          };
        };
      };
      sonarr = {
        enable = true;
        user = "media";
        group = "media";
        settings = {
          server = {
            port = 8989;
          };
        };
      };
      prowlarr = {
        enable = true;
        settings = {
          server = {
            port = 9696;
          };
        };
      };
      lidarr = {
        enable = true;
        user = "media";
        group = "media";
        settings = {
          server = {
            port = 8686;
          };
        };
      };
      seerr = {
        enable = true;
        port = 5055;
      };
    };
  };
}
