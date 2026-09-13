{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.jellyfin = {
    lib,
    config,
    pkgs,
    ...
  }: {
    services.jellyfin = {
      enable = true;
      hardwareAcceleration = {
        enable = true;
        type = "nvenc";
        device = "/dev/dri/renderD128";
      };
      transcoding = {
        enableHardwareEncoding = true;
        hardwareDecodingCodecs = {
          h264 = true;
          hevc = true;
          hevc10bit = true;
          mpeg2 = true;
          vc1 = true;
          vp8 = true;
          vp9 = true;
        };
        hardwareEncodingCodecs.hevc = true;
      };
    };
    systemd.services.jellyfin.serviceConfig = {
      SystemCallFilter = lib.mkForce [
        "@system-service"
        "ioctl"
        "~@priveleged"
      ];
      DeviceAllow = lib.mkForce [
        "/dev/nvidia0 rw"
        "/dev/nvidiactl rw"
        "/dev/nvidia-uvm rw"
        "/dev/nvidia-modeset rw"
        "/dev/dri/renderD128 rw"
      ];
    };
  };
}
