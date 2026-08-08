{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.lenovoConfiguration = {
    config,
    pkgs,
    ...
  }: let
    secretspath = builtins.toString inputs.secrets;
  in {
    imports = [
      self.nixosModules.lenovoHardware
      self.nixosModules.niri
      self.nixosModules.ly
      self.nixosModules.pipewire
      self.nixosModules.yazi
      self.nixosModules.vim
      self.nixosModules.nvf
      self.nixosModules.tmux
      self.nixosModules.foot
      self.nixosModules.bash
      self.nixosModules.localCA
      self.nixosModules.customFonts
      self.nixosModules.virt-manager
      self.nixosModules.wg-quick

      inputs.sops-nix.nixosModules.sops
    ];

    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot = {
          enable = true;
        };
      };
    };
    boot.kernelPackages = pkgs.linuxPackages_zen;

    networking.hostName = "lenovo";

    networking.networkmanager.enable = true;
    time.timeZone = "Asia/Kolkata";

    users.users.kin = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.bash;
      home = "/home/kin/";
      packages = with pkgs; [
        libnotify
        usbutils
        glib
        wine-wayland
        protontricks
        wget
        home-manager
        bat
        unzip
        zip
        sops

      ];
    };

    sops = {
      defaultSopsFile = "${secretspath}/secrets/server.yaml";
      age = {
        sshKeyPaths = ["${config.users.users.kin.home}/.ssh/id_ed25519"];
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };
    };

    services.gvfs.enable = true;

    nix.settings.experimental-features = ["nix-command" "flakes"];

    programs = { 
      dconf.enable = true;
      localsend.enable = true;
    };

    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    environment = { 
      systemPackages = with pkgs; [
        git
        mullvad
        mullvad-vpn

        inputs.xwayland-satellite-unscaled.packages.${pkgs.system}.xwayland-satellite
      ];
      variables = {
        EDITOR = "emacsclient -c";};
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
    networking.wireless.enable = false;
    networking.wireless.iwd.enable = true;
    networking.networkmanager.wifi.backend = "iwd";

    systemd.services.systemd-rfkill.enable = false;
    systemd.sockets.systemd-rfkill.enable = false;

    services.mullvad-vpn = {
      enable = true;
    };
    
    swapDevices = [
      { 
        device = "/var/lib/swapfile";
        size = 64 * 1024;
      }
    ];
    system.stateVersion = "25.11";
  };
}
