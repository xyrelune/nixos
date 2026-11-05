{
  self,
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.homeModules.rofi = moduleWithSystem ({
    pkgs,
    self',
    ...
  }: {
    programs.rofi = {
      enable = true;
      package = self'.packages.myRofi;
    };
  });
  perSystem = {
    pkgs,
    ...
  }: {
    packages.myRofi = inputs.wrapper-modules.wrappers.rofi.wrap {
      inherit pkgs;
      theme = "gruvbox-dark";
    };
  };
}
