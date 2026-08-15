{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.wg-quick = {
    lib,
    config,
    ...
  }: {
    sops.secrets = {
      "wg-quick/laptop/private_key" = {};
      "wg-quick/laptop/psk" = {};
      "wg-quick/lenovo/private_key" = {};
    };
    systemd.services.wg-quick-wg0.wantedBy = lib.mkForce [];
    systemd.services.wg-quick-lenovo.wantedBy = lib.mkForce [];
    networking.wg-quick.interfaces = {
      wg0 = {
        address = [
          "10.0.1.11/24"
        ];
        dns = [ "192.168.0.1" ];
        privateKeyFile = config.sops.secrets."wg-quick/laptop/private_key".path;
        peers = [
          {
            publicKey = "UvvGldyGgF4dtj71VLd0Xwqs9NM9j2ElzYqLrIXxkV4=";
            allowedIPs = [
              "0.0.0.0/0"
              "::/0"
            ];
            endpoint = "peanutbutter.quest:4444"; 
            presharedKeyFile = config.sops.secrets."wg-quick/laptop/psk".path;
          }
        ];
      };
      lenovo = {
        address = [
          "10.0.0.4/32"
        ];
        dns = [ "192.168.0.1" ];
        privateKeyFile = config.sops.secrets."wg-quick/lenovo/private_key".path;
        peers = [
          {
            publicKey = "CctP255U9x7ZhnEvQ4cN4/LjXkfZpcc4ErJR5zkjXQk=";
            allowedIPs = [
              "0.0.0.0/0"
            ];
            endpoint = "peanutbutter.quest:53";
          }
        ];
      };
    };
  };
}
