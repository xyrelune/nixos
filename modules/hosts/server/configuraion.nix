{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.serverConfiguration = {
    config,
    pkgs,
    ...
  }: let
    secretspath = builtins.toString inputs.secrets;
  in {
    imports = [
      self.nixosModules.serverHardware
      self.nixosModules.localCA
      self.nixosModules.vim
      self.nixosModules.nvf
      self.nixosModules.tmux
      self.nixosModules.searxng
      self.nixosModules.nginx
      self.nixosModules.qbittorrent
      self.nixosModules.vaultwarden
      self.nixosModules.komga
      self.nixosModules.miniflux
      self.nixosModules.docker
      self.nixosModules.bash
      self.nixosModules.yazi
      self.nixosModules.stirlingpdf
      self.nixosModules.whatmp3
      self.nixosModules.linkwarden
      self.nixosModules.wireguard
      self.nixosModules.arr
      self.nixosModules.jellyfin
      self.nixosModules.copyparty
      self.nixosModules.rclone
      self.nixosModules.radicale
      self.nixosModules.navidrome

      inputs.sops-nix.nixosModules.sops
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    #boot.kernelPackages = pkgs.linuxPackages_latest;
    nix.settings.experimental-features = ["nix-command" "flakes"];
    users = {
      users = {
        kin = {
          isNormalUser = true;
          description = "kin";
          extraGroups = [ "wheel" "docker" "media" ];
          shell = pkgs.bash;
          home = "/home/kin";
          openssh = {
            authorizedKeys = {
              keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIS+eKj19lpFfENzaduMCgAqd6Borror02S8o2OF3Aiu vaultwarden"
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBl9/46Fjl8qpf1IdPXrWYbBuCtHJhQhr93MdDgTxM5m kin@lenovo"
              ];
            };
          };
        };
        media = {
          isSystemUser = true;
          group = "media";
          home = "/var/lib/media";
          createHome = true;
        };
      };
      groups = {
        media = {};
      };
    };

    virtualisation.docker = {
      enable = true;
    };
    
    sops = {
      defaultSopsFile = "${secretspath}/secrets/server.yaml";
      age = {
        sshKeyPaths = ["${config.users.users.kin.home}/.ssh/id_ed25519"];
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };
      secrets = {
        lidarr_api_key = {};
        lidarr_api_env = {};
        radarr_api_key = {};
        radarr_api_env = {};
        sonarr_api_key = {};
        sonarr_api_env = {};
      };
    };
    boot.loader.grub.device = "/dev/nvme0n1p1";
    environment.systemPackages = with pkgs; [
      git
      git-lfs
      bat
      htop
      home-manager
      ntfs3g
      brightnessctl
      gh
      fastfetch
      age
      kitty
      sops
      compose2nix
      unzip
      zip
      streamrip
      ffmpeg
      btop
    ];
    networking = {
      hostName = "server";
      useDHCP = true;
      firewall = {
        enable = false;
        allowedTCPPorts = [25575 25565 80 443 7878 8989 9696 42010];
        allowedUDPPorts = [19132 5544 25565 9];
        extraCommands = "  iptables -t mangle -A POSTROUTING -p tcp --tcp-flags SYN,RST SYN \
        -j TCPMSS --clamp-mss-to-pmtu";
      };
      interfaces = {
        eno1 = {
          mtu = 1250;
          wakeOnLan.enable = true;
        };
      };
    };
    systemd.services.set-brightness = {
      description = "Set screen brightness to 0";
      wantedBy = [ "multi-user.target" ];
      after = [ "systemd-backlight@backlight:intel_backlight.service" ];

      serviceConfig.Type = "oneshot";

      script = ''
        echo 0 > /sys/class/backlight/intel_backlight/brightness
      '';
    };

    services.vsftpd = {
      enable = true;
      localUsers = true;
      writeEnable = false;
      extraConfig = ''
        local_enable=YES
        pasv_enable=YES
        pasv_min_port=40000
        pasv_max_port=40100
      '';
    };
    security.pam.services.vsftpd = {
      unixAuth = true;
    };

    swapDevices = [
      {
        device = "/.swapfile";
        size = 16 * 1024; # Size in Megabytes
      }
    ];
    time.timeZone = "Asia/Kolkata";
    services.openssh.enable = true;
    system.stateVersion = "25.11"; # Did you read the comment?
  };
}
