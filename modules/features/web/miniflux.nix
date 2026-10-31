{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.miniflux = {
    config,
    lib,
    ...
  }: {
    sops.secrets = {
      "miniflux/admin-credentials" = {};
    };
    services.miniflux = {
      enable = true;
      config = {
        CREATE_ADMIN = true;
        PORT = 9090;
      };
      adminCredentialsFile = config.sops.secrets."miniflux/admin-credentials".path;
    };
  };
}
