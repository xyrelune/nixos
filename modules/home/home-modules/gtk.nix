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
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3; 
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
