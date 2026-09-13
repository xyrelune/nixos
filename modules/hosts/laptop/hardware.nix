{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.laptopHardware = {
    config,
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/63be889f-1491-47be-bc6c-820884e007b9";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/6728-D654";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    #swapDevices = [
    #  {device = "/dev/disk/by-uuid/7f2a8bf2-2460-4446-bdec-327811c5be57";}
    #];  

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
