{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.kavita = {
    pkgs,
    ...
  }: {
    services.kavita = {
      enable = true;
    };
  };
}
