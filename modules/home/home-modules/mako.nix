{
  self,
  inputs,
  ...
}: {
  flake.homeModules.mako = {
    pkgs,
    ...
  }: {
    services.mako = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myMako;
    };
  };
  perSystem = {
    pkgs,
    ...
  }: {
    packages.myMako = inputs.wrapper-modules.wrappers.mako.wrap {
      inherit pkgs;
      settings = {
        sort = "-time";
        font = "Iosevka Nerd Font Mono";
        layer = "overlay";
        anchor = "top-right";
        default-timeout = 5000;
        width = 300;
        height = 110;
        padding = "0,15,20";
        background-color = "#1a1b26";
        text-color = "#c0caf5";
        border-color = "#7aa2f7";
        progress-color = "#414868";
        
        "urgency=low" = {
          border-color = "#565f89";
        };
        
        "urgency=normal" = {
          border-color = "#7aa2f7";
        };
        
        "urgency=high" = {
          border-color = "#f7768e";
          default-timeout = 0;
        };
      };
    };
  };
}
