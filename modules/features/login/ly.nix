{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.ly = {
    pkgs,
    lib,
    ...
  }: {
    services.displayManager.ly = {
      enable = true;
      settings = {
        clear_password = true;
      };
    };
  };
}
