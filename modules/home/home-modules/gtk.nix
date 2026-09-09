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
        name = "Gruvbox-Dark";
        package = pkgs.gruvbox-gtk-theme; 
      };
      iconTheme = {
        package = pkgs.gruvbox-plus-icons;
        name = "Gruvbox-Plus-Dark";
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
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };
}
