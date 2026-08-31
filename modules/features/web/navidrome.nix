{
  self,
  input,
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
      plugins = with pkgs.navidromePlugins; [
        discord-rich-presence
        apple-music
      ];
      settings = {
        MusicFolder = "/mnt/downloads/personal-music";
        Plugins = {
          Enabled = true;
        };
        Agents = "apple-music,deezer,lastfm";
        ListenBrainz.BaseURL = "http://127.0.0.1:9078/1/";
      };
    };
    systemd.services.navidrome.serviceConfig.BindReadOnlyPaths = [
      "/mnt/external-hdd/stream/music"
    ];
  };
}
