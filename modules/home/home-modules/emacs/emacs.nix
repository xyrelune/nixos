{
  ...
}: {
  flake.homeModules.emacs = {
    config,
    pkgs,
    ...
  }: { 
    services.emacs = {
      enable = true;
      package = config.programs.emacs.finalPackage;
      client.enable = true;
      defaultEditor = true;
      startWithUserSession = true;
    };
    home.packages = with pkgs; [
      nixd
      python314
      pyright
    ];
    programs.emacs = {
      enable = true;
      package = (pkgs.emacs-pgtk.override { withTreeSitter = true; });

      extraPackages = epkgs: with epkgs; [
        evil
        evil-collection
        nerd-icons
				vterm
				autothemer
				nix-mode
        rainbow-mode
        pdf-tools
        emms
        base16-theme
        yaml-mode
        powershell
        multi-vterm
        magit
        vterm-toggle
        ghostel
        evil-ghostel
        org
        org-caldav
        org-autolist
      ];
    };

    home.file = {
      emacs = {
        source = ./init.el;
        target = ".emacs.d/init.el";
      };
      emacs-init = {
        source = ./early-init.el;
        target = ".emacs.d/early-init.el";
      };
    };
  };
}
