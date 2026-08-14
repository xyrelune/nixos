{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.docker = {
    pkgs,
    lib,
    config,
    ...
  }: {
    sops.secrets = {
      "vaultwarden-backup.env" = {};
    };
    # Runtime
    virtualisation.podman = {
        enable = true;
        defaultNetwork = {
          settings = {
            dns_enabled = false;
          };
        };
        autoPrune.enable = true;
    };

    # Enable container name DNS for all Podman networks.
    networking.firewall.interfaces = let
        matchAll = if !config.networking.nftables.enable then "podman+" else "podman*";
    in {
        "${matchAll}".allowedUDPPorts = [ 53 ];
    };

    virtualisation.oci-containers.backend = "podman";

    # Containers
    virtualisation.oci-containers.containers."multi-scrobbler" = {
        image = "foxxmd/multi-scrobbler:latest";
        environment = {
        "BASE_URL" = "http://192.168.0.122:9078";
        "PGID" = "100";
        "PUID" = "1000";
        "TZ" = "Asia/Kolkata";
        };
        volumes = [
        "/home/kin/data/multi-scrobbler/config:/config:rw"
        ];
        ports = [
        "9078:9078/tcp"
        ];
        log-driver = "journald";
        extraOptions = [
        "--network-alias=multi-scrobbler"
        "--network=services_default"
        ];
    };
    systemd.services."podman-multi-scrobbler" = {
        serviceConfig = {
        Restart = lib.mkOverride 90 "always";
        };
        after = [
        "podman-network-services_default.service"
        ];
        requires = [
        "podman-network-services_default.service"
        ];
        partOf = [
        "podman-compose-services-root.target"
        ];
        wantedBy = [
        "podman-compose-services-root.target"
        ];
    };
    virtualisation.oci-containers.containers."recyclarr" = {
        image = "ghcr.io/recyclarr/recyclarr:8";
        environment = {
        "PGID" = "100";
        "PUID" = "1000";
        "TZ" = "Asia/Kolkata";
        };
        volumes = [
        "/home/kin/data/recyclarr:/config:rw"
        ];
        log-driver = "journald";
        extraOptions = [
        "--network-alias=recyclarr"
         "--network=services_default"
         ];
    };
    systemd.services."podman-recyclarr" = {
        serviceConfig = {
        Restart = lib.mkOverride 90 "no";
        };
        after = [
        "podman-network-services_default.service"
        ];
        requires = [
        "podman-network-services_default.service"
        ];
        partOf = [
        "podman-compose-services-root.target"
        ];
        wantedBy = [
        "podman-compose-services-root.target"
        ];
    };
    virtualisation.oci-containers.containers."deluge" = {
      image = "lscr.io/linuxserver/deluge:latest";
      environment = {
        "DELUGE_LOGLEVEL" = "error";
        "PGID" = "169";
        "PUID" = "980";
        "TZ" = "Asia/Kolkata";
      };
      volumes = [
        "/home/kin/data/deluge/config:/config:rw"
        "/mnt/external-hdd/downloads:/downloads:rw"
        "/mnt/manga:/manga:rw"
      ];
      ports = [
        "8112:8112/tcp"
        "6881:6881/tcp"
        "6881:6881/udp"
        "58846:58846/tcp"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=deluge"
        "--network=services_default"
      ];
    };
    systemd.services."podman-deluge" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-services_default.service"
      ];
      requires = [
        "podman-network-services_default.service"
      ];
      partOf = [
        "podman-compose-services-root.target"
      ];
      wantedBy = [
        "podman-compose-services-root.target"
      ];
    };
    virtualisation.oci-containers.containers."vaultwarden-backup" = {
      image = "ttionya/vaultwarden-backup:latest";
      environmentFiles = [
        config.sops.secrets."vaultwarden-backup.env".path
      ];
      volumes = [
        "/home/kin/data/vaultwarden-backup/rclone-data:/config:rw"
        "/var/lib/vaultwarden:/bitwarden/data:rw"
      ];
      labels = {
        "compose2nix.settings.sops.secrets" = "vaultwarden-backup.env";
      };
      log-driver = "journald";
      extraOptions = [
        "--network-alias=vaultwarden-backup"
        "--network=services_default"
      ];
    };
    systemd.services."podman-vaultwarden-backup" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-services_default.service"
      ];
      requires = [
        "podman-network-services_default.service"
      ];
      partOf = [
        "podman-compose-services-root.target"
      ];
      wantedBy = [
        "podman-compose-services-root.target"
      ];
    };
    # Networks
    systemd.services."podman-network-services_default" = {
        path = [ pkgs.podman ];
        serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "podman network rm -f services_default";
        };
        script = ''
        podman network inspect services_default || podman network create services_default
        '';
        partOf = [ "podman-compose-services-root.target" ];
        wantedBy = [ "podman-compose-services-root.target" ];
    };
    # Root service
    # When started, this will automatically create all resources and start
    # the containers. When stopped, this will teardown all resources.
    systemd.targets."podman-compose-services-root" = {
        unitConfig = {
        Description = "Root target generated by compose2nix.";
        };
        wantedBy = [ "multi-user.target" ];
    };
  };
}
