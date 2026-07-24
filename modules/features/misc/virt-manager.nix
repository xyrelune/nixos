{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.virt-manager = {
    config,
    pkgs,
    ...
  }: let
    user = "kin";
    platform = "amd";
    vfioIds = [ "10de:2560" "10de:228e" ];
  in  {
    boot = {
      kernelModules = [ "kvm-${platform}"  "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
      kernelParams = [ "${platform}_iommu=on" "${platform}_iommu=pt" "kvm.ignore_msrs=1" ];
      extraModprobeConfig = "options vfio-pci ids=${builtins.concatStringsSep "," vfioIds}"; 
    };
    systemd.tmpfiles.rules = [
        "f /dev/shm/looking-glass 0660 ${user} qemu-libvirtd -"
    ];
    environment.systemPackages = with pkgs; [
      dnsmasq

      (pkgs.writeShellScriptBin "looking-glass" ''
        exec ${pkgs.systemd}/bin/systemd-inhibit \
          --what=idle\
          --why="Looking Glass" \
          ${pkgs.looking-glass-client}/bin/looking-glass-client "$@"
      '')
    ];
    networking.firewall.trustedInterfaces = [ "vibr0" ];

    users.users.kin.extraGroups = [ "libvirtd" "qemu-libvirtd" "disk" "kvm" ];
    virtualisation = {
      libvirtd = {
        enable = true;
        extraConfig = ''
          user="${user}"
        '';
        onBoot = "ignore";
        onShutdown = "shutdown";
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          verbatimConfig = ''
            namespaces = []
          '';
        };
      };
    };
    programs = {
      virt-manager = {
        enable = true;
      };
    };
  };
}
