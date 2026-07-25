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
      self.homeModules.lock
      self.homeModules.mako
      self.homeModules.alacritty
      self.homeModules.gtk
      self.homeModules.fuzzel
      self.homeModules.firefox
      self.homeModules.helix
      self.homeModules.chromium
      self.homeModules.gtk-fonts
      self.homeModules.emacs
      self.homeModules.waybar
      self.homeModules.rmpc
      self.homeModules.mpd

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

        (discord.override {
          withOpenASAR = true;
          withEquicord = true;
        })

        inputs.prismlauncher.packages.${pkgs.system}.prismlauncher

        nur.repos.tnmt.brave-origin
      ];
      sessionVariables = {
        GTK_DEBUG = "portals";
        GTK_USE_PORTAL = 1;
        SSH_AUTH_SOCK = "/home/kin/.bitwarden-ssh-agent.sock";
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
