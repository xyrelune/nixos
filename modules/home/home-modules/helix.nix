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
        theme =  "tokyonight";
      };
      themes."transparent" = {
        inherits = "kanagawa";
        "ui.background" = {};
      };
    };
  };
}
