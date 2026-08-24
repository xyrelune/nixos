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
        "/mnt" = {
          path = "/mnt";
          access = {
            rw = [ "kin" ];
          };
          flags = {
            scan = 60;
            e2d = true;
          };
        };
        "/personal-music" = {
          path = "/home/kin/personal-music";
          access = {
            rw = [ "kin" ];
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
