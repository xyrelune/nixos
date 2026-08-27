{
  self,
  input,
  ...
}: {
  flake.nixosModules.navidrome = {
    services.navidrome = {
      enable = true;
      settings = {
        MusicFolder = "/home/kin/personal-music";
      };
    };
  };
}
