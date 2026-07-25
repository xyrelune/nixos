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
        "vault.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
        };
        "search.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
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
        "scrobble.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
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
        "linkwarden.server.org" = {
          forceSSL = true;
          sslCertificate = "/etc/ssl/local/server.org.pem";
          sslCertificateKey = "/etc/ssl/local/server.org-key.pem";
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
    security.acme = {
      defaults.email = "clovertight@gmail.com";
      acceptTerms = true;
    };

    systemd.services.nginx.serviceConfig.ProtectHome = false;
  };
}
