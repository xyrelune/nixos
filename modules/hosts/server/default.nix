{
  withSystem,
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.server = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.serverConfiguration
      ({pkgs, ...}: {
        nixpkgs.config.allowUnfree = true;
        nixpkgs.overlays = [
        ];
      })
    ];
  };
}
