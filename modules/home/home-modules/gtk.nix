{
  self,
  ...
}: {
  flake.homeModules.gtk = {
    pkgs,
    ...
  }: {
    gtk = {
      enable = true;
      gtk4.theme = null;
      theme = {
        name = "Kanagawa-B-LB";
        package = pkgs.kanagawa-gtk-theme; 
      };
    };
    qt = {
      enable = true;
      platformTheme.name = "gtk3";
    };            
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      };
    };
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  };
}
