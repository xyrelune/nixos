{
  withSystem,
  self,
  inputs,
  ...
}: {
  flake.homeConfigurations.kin-laptop = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      overlays = [
        inputs.nur.overlays.default
        inputs.helium.overlays.default
        inputs.emacs-overlay.overlays.default
      ];
    };
    modules = [
      self.homeModules.kinConfiguration
      ({pkgs, ...}: {
        nixpkgs.config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-39.8.10"
          ];
        };
      })
    ];
  };
}
