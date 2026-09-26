{
  self,
  inputs,
  ...
}: { 
  fake.nixosModules.searxng = {config, pkgs, ...}: 
  let 
    unstable = import inputs.nixpkgs {
      system = pkgs.stdenv.hostPlatform.system;
    };
  in {
    sops.secrets = {
      "searxng/secret_key" = {};
    };

    services.searx = {
      enable = true;
      domain = "search.server.org";
      configureNginx = true;
      package = unstable.searxng;
    };
  };
}
