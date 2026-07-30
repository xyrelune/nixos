{
  self,
  inputs,
  ...
}: {
  flake.homeModules.librewolf = {
    pkgs,
    ...
  }: {
    programs.librewolf = {
      enable = true;
      profiles = {
        standard = {
          id = 0;
          name = "standard";
          isDefault = true;
          settings = {
            "webgl.disabled" = false;
            "privacy.resistFingerprinting" = false;
            "privacy.clearOnShutdown.history" = false;
            "privacy.clearOnShutdown.cookies" = false;
            "network.cookie.lifetimePolicy" = 0;
          };
          extensions = {
            force = true;
            packages = with pkgs.nur.repos.rycee.firefox-addons; [
              ublock-origin
              sponsorblock
              violentmonkey
              floccus
              enhancer-for-youtube
              stylus
            ];
          };
        };
      };
    };
  };
}
