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
        font = "Source Sans Pro";
        layer = "overlay";
        anchor = "top-right";
        default-timeout = 5000;
        width = 300;
        height = 110;
        padding = "0,15,20";
        background-color = "#1f1f28";
        
        "urgency=normal" = {
            border-color = "#7e9cd8";
        };
        
        "urgency=high" = {
            border-color = "#e82424";
            default-timeout = 0;
        };
      };
    };
  };
}
