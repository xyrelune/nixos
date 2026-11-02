{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.copyparty = {
    config,
    ...
  }: {
    imports = [
      inputs.copyparty.nixosModules.default
    ];
    sops.secrets = {
      "copyparty/kin/password" = {
        owner = config.services.copyparty.user;
      };
    };
    services.copyparty = {
      enable = true;
      user = "kin";
      group = "users";
      settings = {
        i = "0.0.0.0";
        ban-404 = false;
        ban-403 = false;
        ban-422 = false;
        ban-url = false;
        ban-pw = false;
      };
      accounts = {
        kin.passwordFile = config.sops.secrets."copyparty/kin/password".path;
      };
      
      volumes = {
        "/" = {
          path = "/home/kin/data/copyparty";
          access = {
            rw = [ "kin" ];
          };
          flags = {
            scan = 60;
            e2d = true;
          };
        };
        "/flac-music" = {
          path = "/mnt/downloads/flac-music";
          access = {
            r = [ "kin" ];
          };
          flags = {
            scan = 60;
            e2d = true;
          };
        };
        "/nsfw" = {
          path = "/mnt/external-hdd/downloads/nsfw";
          access = {
            r = [ "kin" ];
          };
          flags = {
            scan = 60;
            e2d = true;
          };
        };
      };
    };
  };
}
