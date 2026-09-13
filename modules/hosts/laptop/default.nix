{
  withSystem,
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.laptopConfiguration
      ({pkgs, ...}: {
        nixpkgs.config.allowUnfree = true;
        nixpkgs.overlays = [
        ];
      })
    ];
  };
}
