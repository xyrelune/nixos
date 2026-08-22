{
  self,
  input,
  ...
}: {
  flake.nixosModules.radicale = {
    config,
    ...
  }: {
    sops.secrets = {
      "radicale/password" = {
        owner = "radicale";
        group = "radicale";
        mode = "0400";
      };
    };
    services.radicale = {
      enable = true;
      settings = {
        server = {
          hosts = [ "0.0.0.0:5232" ];
        };
        auth = {
          type = "htpasswd";
          htpasswd_filename = config.sops.secrets."radicale/password".path;
          htpasswd_encryption = "plain";
        };
      };
    };
  };
}
