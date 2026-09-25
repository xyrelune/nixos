{
  self,
  inputs,
  ...
}: {
  flake.homeModules.emacs = {
    config,
    pkgs,
    lib,
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
      texliveFull
    ];
    programs.emacs = {
      enable = true;
      package = (pkgs.emacs-pgtk.override { withTreeSitter = true; });

      extraPackages = epkgs: with epkgs; [
        evil
        evil-collection
        eat
        nerd-icons
        vterm
        nix-mode
        rainbow-mode
        pdf-tools
        yaml-mode
        powershell
        multi-vterm
        magit
        vterm-toggle
        org
        org-autolist
        gruvbox-theme
        nerd-icons-dired
        bash-completion
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
      eshell-alias = {
        source = ./alias;
        target = ".emacs.d/eshell/alias";
      };
    };
  };
}
