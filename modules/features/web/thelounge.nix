{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.thelounge = {
    pkgs,
    ...
  }: {
    services.thelounge = {
      enable = true;
    };
  };
}
