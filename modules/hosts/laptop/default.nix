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
        nixpkgs = {
          config.allowUnfree = true;
          overlays = [
            inputs.helium.overlays.default
            inputs.emacs-overlay.overlays.default
          ];
        };
      })
    ];
  };
}
