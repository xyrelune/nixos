{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    prismlauncher.url = "github:PrismLauncher/PrismLauncher?ref=release-9.x";
    xwayland-satellite-unscaled.url = "github:Supreeeme/xwayland-satellite?ref=unscaled-dpi";
    redlib-fork.url = "github:taglia/redlib?ref=dockerhub-redlib-0.36.0";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    copyparty.url = "github:9001/copyparty";

    secrets = {
      url = "git+ssh://git@github.com/xyrelune/nix-secrets?ref=main&shallow=1";
      flake = false;
    };
    walls = {
      url = "git+ssh://git@github.com/xyrelune/walls?ref=main&shallow=1";
      flake = false;
    };
    custom-fonts = {
      url = "git+ssh://git@github.com/xyrelune/custom-fonts?ref=main&shallow=1";
      flake = false;
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixflix = {
      url = "github:kiriwalawren/nixflix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sidra = {
      url = "github:wimpysworld/sidra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
