{
  self,
  inputs,
  ...
}: {
  flake.homeModules.kinConfiguration = {
    config,
    pkgs, 
    ...
  }: let
    secretspath = builtins.toString inputs.secrets;
  in {
    imports = [
      #self.homeModules.lock
      self.homeModules.mako
      self.homeModules.alacritty
      self.homeModules.gtk
      self.homeModules.fuzzel
      self.homeModules.firefox
      self.homeModules.librewolf
      self.homeModules.helix
      self.homeModules.chromium
      self.homeModules.gtk-fonts
      self.homeModules.emacs
      self.homeModules.waybar
      self.homeModules.easyeffects
      #self.homeModules.rmpc
      #self.homeModules.mpd

      inputs.sops-nix.homeManagerModules.sops
    ];
    home = {
      username = "kin";
      homeDirectory = "/home/kin";
      stateVersion = "25.11";
      packages = with pkgs; [
        spotify
        swappy
        libreoffice
        fastfetch
        qbittorrent-nox
        mpv
        helium
        btop
        lutris
        android-tools
        protonup-qt
        tree
        htop
        p7zip
        blanket
        nwg-look
        lsd
        via
        streamrip
        tidal-hifi
        jellyfin-mpv-shim
        bitwarden-cli
        bitwarden-desktop
        hydra-check
        thunar
        zathura
        speedtest-cli
        vlc

        inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
        zulu25
      ];
      sessionVariables = {
        GTK_DEBUG = "portals";
        GTK_USE_PORTAL = 1;
        QT_QPA_PLATFORM = "wayland";
      };
    };
    sops = {
      defaultSopsFile = "${secretspath}/secrets/server.yaml";
      age = {
        sshKeyPaths = ["/home/kin/.ssh/id_ed25519"];
        keyFile = "/home/kin/.config/sops/age/keys.txt";
        generateKey = true;
      };
    };
  };
}
