{
  self,
  input,
  ...
}: {
  flake.nixosModules.navidrome = {
    services.navidrome = {
      enable = true;
      user = "media";
      group = "media";
      settings = {
        MusicFolder = "/home/kin/personal-music";
      };
    };
  };
}
