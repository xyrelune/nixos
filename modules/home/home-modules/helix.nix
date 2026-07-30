{ 
  ...
}: {
  flake.homeModules.helix = {
    pkgs,
    ...
  }: {
    programs.helix = {
      enable = true;
      package = pkgs.evil-helix;
      settings = {
        theme =  "transparent";
      };
      themes."transparent" = {
        inherits = "kanagawa";
        "ui.background" = {};
      };
    };
  };
}
