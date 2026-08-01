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
          #font = "Source Sans Pro:size=12";
          list-executables-in-path = "yes";
        };
        colors = {
          background = "1f1f28ff";
          text = "dcd7baff";
          match = "ffa066ff";
          selection = "2a2a37ff";
          selection-match = "e6c384ff";
          selection-text = "dcd7baff";
          border = "54546dff";
        };
      };
    };
  };
}
