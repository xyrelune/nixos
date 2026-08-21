{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nginx = {
    config,
    ...
  }: {
    services.nginx = {
      enable = true;

      recommendedGzipSettings = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      recommendedOptimisation = true;

      virtualHosts = {
        "vault.peanutbutter.quest" = {
          forceSSL = true;
          enableACME = true;
        };
        "search.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
        };
        "search.peanutbutter.quest" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://unix:${config.services.anubis.instances.search.settings.BIND}";
          };
        };
        "pdf.peanutbutter.quest" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://unix:${config.services.anubis.instances.pdf.settings.BIND}";
          };
        };
        "deluge.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
          locations."/" = {
            proxyPass = "http://127.0.0.1:8112";
            proxyWebsockets = true;
          };
        };
        "rss.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
          locations."/" = {
            proxyPass = "http://127.0.0.1:9090";
            proxyWebsockets = true;
          };
        };
        "scrobble.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
          locations."/" = {
            proxyPass = "http://127.0.0.1:9078";
            proxyWebsockets = true;
          };
        };
        "scrobble.peanutbutter.quest" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:9078";
            proxyWebsockets = true;
          };
        };
        "party.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
          locations."/" = {
            proxyPass = "http://127.0.0.1:3923";
            proxyWebsockets = true;
          };
        };
        "jellyfin.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
          locations."/" = {
            proxyPass = "http://127.0.0.1:8096";
            proxyWebsockets = true;
          };
        };
        "jf.peanutbutter.quest" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8096";
            proxyWebsockets = true;
          };
        };
        "linkwarden.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
          locations."/" = {
            proxyPass = "http://127.0.0.1:3000";
            proxyWebsockets = true;
          };
        };
        "linkwarden.peanutbutter.quest" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:3000";
            proxyWebsockets = true;
          };
        };
        "komga.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
          locations."/" = {
            proxyPass = "http://127.0.0.1:10060";
            proxyWebsockets = true;
          };
        };
        "radarr.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
          locations."/" = {
            proxyPass = "http://127.0.0.1:7878";
            proxyWebsockets = true;
          };
        };
        "sonarr.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
          locations."/" = {
            proxyPass = "http://127.0.0.1:8989";
            proxyWebsockets = true;
          };
        };
        "prowlarr.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
          locations."/" = {
            proxyPass = "http://127.0.0.1:9696";
            proxyWebsockets = true;
          };
        };
        "lidarr.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
          locations."/" = {
            proxyPass = "http://127.0.0.1:8686";
            proxyWebsockets = true;
          };
        };
        "qb.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
          locations."/" = {
            proxyPass = "http://127.0.0.1:8888";
            proxyWebsockets = true;
          };
        };
      };
    };
    services.anubis = {
      instances = {
        search = {
          enable = true;
          settings = {
            TARGET = "http://127.0.0.1:8080";
          };
        };
        pdf = {
          enable = true;
          settings = {
            TARGET = "http://127.0.0.1:8877";
          };
        };
      };
    };
    users.users.nginx.extraGroups = [
      config.users.groups.anubis.name
    ];
    security.acme = {
      defaults.email = "clovertight@gmail.com";
      acceptTerms = true;
    };

    systemd.services.nginx.serviceConfig.ProtectHome = false;
  };
}
