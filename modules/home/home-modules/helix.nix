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
        theme =  "kanagawa";
      };
      themes."transparent" = {
        inherits = "kanagawa";
        "ui.background" = {};
      };
    };
  };
}
