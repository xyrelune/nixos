{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.serverHardware = {
    config,
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
    fileSystems."/mnt/external-hdd" = {
      device = "/dev/disk/by-uuid/e6ab5a96-b8f5-4081-ba4a-5d2dca6f3bb5";
      fsType = "ext4";
      options = ["nofail"];
    };
    fileSystems."/mnt/multimedia" = {
      device = "/dev/disk/by-label/multimedia";
      fsType = "ext4";
      options = ["nofail"];
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
