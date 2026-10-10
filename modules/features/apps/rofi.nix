{
  self,
  inputs,
  ...
}: {
  flake.homeModules.rofi = {
    pkgs,
    ...
  }: {
    programs.rofi = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myRofi;
    };
  };
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
