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
      vaultwarden-backup.env = {};
    };
    # Runtime
    virtualisation.podman = {
        enable = true;
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
   virtualisation.oci-containers.containers."piped-backend" = {
     image = "nieveve/piped-backend:latest";
     volumes = [
       "/home/kin/Piped-Docker/config/config.properties:/app/config.properties:ro"
     ];
     ports = [
       "10101:8080/tcp"
     ];
     dependsOn = [
       "piped-postgres"
     ];
     log-driver = "journald";
     extraOptions = [
       "--network-alias=piped"
       "--network=services_default"
     ];
   };
   systemd.services."podman-piped-backend" = {
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
   virtualisation.oci-containers.containers."piped-bg-helper" = {
     image = "1337kavin/bg-helper-server:latest";
     log-driver = "journald";
     extraOptions = [
       "--network-alias=bg-helper"
       "--network=services_default"
     ];
   };
   systemd.services."podman-piped-bg-helper" = {
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
   virtualisation.oci-containers.containers."piped-frontend" = {
     image = "1337kavin/piped-frontend:latest";
     environment = {
       "BACKEND_HOSTNAME" = "pipedapi.server.org";
       "HTTP_MODE" = "https";
     };
     ports = [
       "10100:80/tcp"
     ];
     dependsOn = [
       "piped-backend"
     ];
     log-driver = "journald";
     extraOptions = [
       "--cap-add=NET_BIND_SERVICE"
       "--network-alias=frontend"
       "--network=services_default"
     ];
   };
   systemd.services."podman-piped-frontend" = {
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
   virtualisation.oci-containers.containers."piped-postgres" = {
     image = "pgautoupgrade/pgautoupgrade:16-alpine";
     environment = {
       "POSTGRES_DB" = "piped";
       "POSTGRES_PASSWORD" = "changeme";
       "POSTGRES_USER" = "piped";
     };
     volumes = [
       "/home/kin/Piped-Docker/data/db:/var/lib/postgresql/data:rw"
     ];
     log-driver = "journald";
     extraOptions = [
       "--network-alias=postgres"
       "--network=services_default"
     ];
   };
   systemd.services."podman-piped-postgres" = {
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
   virtualisation.oci-containers.containers."piped-proxy" = {
     image = "1337kavin/piped-proxy:latest";
     ports = [
       "10102:8080/tcp"
     ];
     log-driver = "journald";
     extraOptions = [
       "--network-alias=proxy"
       "--network=services_default"
     ];
   };
   systemd.services."podman-piped-proxy" = {
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
    virtualisation.oci-containers.containers."services-fourget" = {
        image = "luuul/4get:latest";
        environment = {
        "FOURGET_PROTO" = "http";
        "FOURGET_SERVER_NAME" = "4get.peanutbutter.quest";
        };
        ports = [
        "10030:80/tcp"
        ];
        log-driver = "journald";
        extraOptions = [
        "--network-alias=fourget"
        "--network=services_default"
        ];
    };
    systemd.services."podman-services-fourget" = {
        serviceConfig = {
        Restart = lib.mkOverride 90 "always";
        };
        after = [
        "podman-build-services-fourget.service"
        "podman-network-services_default.service"
        ];
        requires = [
        "podman-build-services-fourget.service"
        "podman-network-services_default.service"
        ];
        partOf = [
        "podman-compose-services-root.target"
        ];
        wantedBy = [
        "podman-compose-services-root.target"
        ];
    };
    virtualisation.oci-containers.containers."services-omnisearch" = {
      image = "localhost/compose2nix/services-omnisearch";
      volumes = [
        "/home/kin/data/omnisearch/example-config.ini:/etc/omnisearch/config.ini:rw"
        "/home/kin/data/omnisearch/locales:/app/locales:rw"
      ];
      ports = [
        "5000:5000/tcp"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=omnisearch"
        "--network=services_default"
      ];
    };
    systemd.services."podman-services-omnisearch" = {
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
    virtualisation.oci-containers.containers."services-yt-dlp-telegram" = {
      image = "localhost/compose2nix/services-yt-dlp-telegram";
      volumes = [
        "/home/kin/data/yt-dlp-telegram/config.py:/app/config.py:ro"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=yt-dlp-telegram"
        "--network=services_default"
      ];
    };
    systemd.services."podman-services-yt-dlp-telegram" = {
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
    # Builds
    systemd.services."podman-build-services-omnisearch" = {
      path = [ pkgs.podman pkgs.git ];
      serviceConfig = {
        Type = "oneshot";
        TimeoutSec = 300;
      };
      script = ''
        cd /home/kin/data/omnisearch
        podman build -t compose2nix/services-omnisearch .
      '';
    };
    systemd.services."podman-build-services-yt-dlp-telegram" = {
      path = [ pkgs.podman pkgs.git ];
      serviceConfig = {
        Type = "oneshot";
        TimeoutSec = 300;
      };
      script = ''
        cd /home/kin/data/yt-dlp-telegram
        podman build -t compose2nix/services-yt-dlp-telegram .
      '';
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
