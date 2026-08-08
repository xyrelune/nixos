{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.jellyfin = {
    pkgs,
    ...
  }: {
    services.jellyfin = {
      enable = true;
      hardwareAcceleration = {
        enable = true;
        type = "vaapi";
        device = "/dev/dri/by-path/pci-0000:00:02.0-render";
      };
    };
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
        vpl-gpu-rt
      ];
    };
  };
}
