{
  self,
  inputs,
  ...
}: {
  flake.homeModules.fuzzel = {
    config,
    pkgs,
    ...
  }: {
    programs.fuzzel = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myFuzzel;
    };
    services.cliphist = {
      enable = true;
    };
    programs.rbw = {
      enable = true;
      settings = {
        base_url = "https://vault.peanutbutter.quest";
        email = "tiredhames@gmail.com";
        lock_timeout = 300;
        pinentry = pkgs.pinentry-qt;
      };
    };
    home.packages = with pkgs; [
      rofi-rbw
      wtype 
      wl-clipboard
      pinentry-qt
    ];
  };
  perSystem = {
    pkgs,
    ...
  }: {
    packages.myFuzzel = inputs.wrapper-modules.wrappers.fuzzel.wrap {
      inherit pkgs;
      settings = {
        main = {
          font = "Iosevka:size=11";
          list-executables-in-path = "yes";
        };
        colors = {
          background       = "28282866";
          text             = "ebdbb2ff";
          match            = "fabd2fff";
          selection        = "3c3836ff";
          selection-match  = "fabd2fff";
          selection-text   = "ebdbb2ff";
          border           = "665c54ff";
        };
      };
    };
  };
}
