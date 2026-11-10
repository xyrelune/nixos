{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.navidrome = {
    pkgs,
    ...
  }: {    
    services.navidrome = {
      enable = true;
      user = "media";
      group = "media";
      settings = {
        MusicFolder = "/mnt/downloads/flac-music";
        Plugins = {
          Enabled = true;
        };
        Agents = "apple-music,deezer,lastfm";
        ListenBrainz.BaseURL = "http://127.0.0.1:9078/1/";
        Address = "0.0.0.0";
      };
    };
    systemd.services.navidrome.serviceConfig.BindReadOnlyPaths = [
      "/mnt/downloads/flac-music"
    ];
  };
}
