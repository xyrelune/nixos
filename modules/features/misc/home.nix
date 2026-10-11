{
   self,
   inputs,
   ...
 }: {
   flake.nixosModules.home = {
     pkgs,
     ...
   }: {
     imports = [
       inputs.home-manager.nixosModules.home-manager
     ];

     home-manager = {
       useGlobalPkgs = true;
       useUserPackages = true;
       backupFileExtension = "backup";

       users.kin = {
        home = {
          username = "kin";
          homeDirectory = "/home/kin/";
          stateVersion = "25.11";
        };
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
          font = {
            name = "Inter";
            size = 12;
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
    };
  };
}
