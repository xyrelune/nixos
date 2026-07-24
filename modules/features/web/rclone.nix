{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.rclone = {
    pkgs,
    config,
    ...
  }: {
    sops.secrets = {
      "rclone/tiredlamp/token/access_token" = {};
      "rclone/tiredlamp/token/refresh_token" = {};
      "rclone/tiredlamp/client_id" = {};
      "rclone/tiredlamp/client_secret" = {};
    };
    sops.templates."rclone.conf".content = ''
      [tiredlamp_gdrive]
      type = drive
      client_id = ${config.sops.placeholder."rclone/tiredlamp/client_id"}
      client_secret = ${config.sops.placeholder."rclone/tiredlamp/client_secret"}
      scope = drive
      token = {"access_token":"${config.sops.placeholder."rclone/tiredlamp/token/access_token"}","token_type":"Bearer","refresh_token":"${config.sops.placeholder."rclone/tiredlamp/token/refresh_token"}","expiry":"2026-07-22T09:30:31.915272781+05:30","expires_in":3599}
      teamdrive = 
    '';
    environment.systemPackages = [ pkgs.rclone ];
    fileSystems."/mnt/tiredlamp" = {
      device = "tiredlamp_gdrive:bitwarden";
      fsType = "rclone";
      options = [
        "nodev"
        "nofail"
        "allow_other"
        "args2env"
        "config=${config.sops.templates."rclone.conf".path}"
      ];
    };
  };    
}                               #
