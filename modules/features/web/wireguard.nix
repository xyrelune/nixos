{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.wireguard = {
    config,
    pkgs,
    ...
  }: {
    sops.secrets = {
      "wireguard/privatekey" = {};
    };

    networking.firewall.allowedUDPPorts = [ 53 ];

    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };   

    networking.nat = {
      enable = true;
      externalInterface = "eno1";
      internalInterfaces = [ "wg0" ];
    };

    networking.wireguard = {
      enable = true;

      interfaces = {
        wg0 = {
          ips = [ "10.0.0.1/24" ];
          listenPort = 53;
          privateKeyFile = config.sops.secrets."wireguard/privatekey".path;

          peers = [
            {
              name = "op9r";
              publicKey = "YJSmpyuD9hdgh4sieucEJI73r0g+BtdofetE0GOrnQk=";
              allowedIPs = [ "10.0.0.2/32" ];
            }
            {
              name = "op13";
              publicKey = "az1SL4LLHRML8O7dTxsvmaY9b9ORXqi0mLCDPdO77hA=";
              allowedIPs = [ "10.0.0.3/32" ];
            }
            {
              name = "lenovo";
              publicKey = "r8ADjGqPjA35Istaxd8cm+1hcq2spc0QREvVuGdO2Fw=";
              allowedIPs = [ "10.0.0.4/32" ];
            }
          ];
        };
      };
    };
  };
}
