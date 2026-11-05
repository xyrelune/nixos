{
  self,
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.bash = moduleWithSystem ({
    pkgs,
    self',
    ...
  }: {
    users.users.kin.packages = [
      self'.packages.bash
    ];
  });
  perSystem =  {
    pkgs,
    ...
  }: {
    packages.bash = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.bashNonInteractive;
      flags = {
        "--rcfile" = ./.bashrc;
      };
    };
  };
}
