{
  self,
  inputs,
  moduleWithSystem,
  ...
}: {
  perSystem =  {
    pkgs,
    ...
  }: {
    packages.bash = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.bash;
      flags = {
        "--rcfile" = ./bashrc;
      };
    };
  };
  flake.nixosModules.bash = moduleWithSystem ({
    pkgs,
    self',
    ...
  }: {
    programs.bash = {
      enable = true;
      package = self'.packages.bash;
      enableLsColors = true;
      completion.package = pkgs.bash-completion;
    };
  });
}
