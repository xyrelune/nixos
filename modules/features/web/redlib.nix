{
  inputs,
  ...
}: {
  flake.nixosModules.redlib = {
    pkgs,
    ...
  }: {
    services.redlib = { 
      enable = true;
      port = 5544;
      package = inputs.redlib-fork.packages.${pkgs.system}.default;

      settings = {
        "REDLIB_DEFAULT_USE_HLS" = "on";
        "REDLIB_DEFAULT_SHOW_NSFW" = "on";
      };
    };
  };
}
