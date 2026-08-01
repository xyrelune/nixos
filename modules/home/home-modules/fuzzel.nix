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
        base_url = "https://vault.server.org";
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
          font = "Iosevka Nerd Font Mono:size=9";
          list-executables-in-path = "yes";
        };
        colors = {
          background = "16161eff";
          text = "c0caf5ff";
          match = "2ac3deff";
          selection = "343a55ff";
          selection-match = "2ac3deff";
          selection-text = "c0caf5ff";
          border = "27a1b9ff";
        };
      };
    };
  };
}
