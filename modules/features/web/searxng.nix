{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.searxng = {config, ...}: {
    sops.secrets = {
      "searxng/secret_key" = {};
    };

    services.searx = {
      enable = true;
      settings = {
        server = {
          port = 8080;
          secret_key = config.sops.secrets."searxng/secret_key".path;
        };
        search = {
          autocomplete = "google";
        };
        ui = {
          url_formatting = "host";
          center_alignment = true;
          results_on_new_tab = true;
        };
      };
      domain = "search.server.org";
      configureNginx = true;
    };
  };
}
