{
  self,
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.yazi = moduleWithSystem ({
    pkgs,
    lib,
    self',
    ...
  }: {
    programs.yazi = {
      enable = true;
      package = self'.packages.myYazi;
    };
  });
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.myYazi = inputs.wrapper-modules.wrappers.yazi.wrap {
      inherit pkgs;
      plugins = with pkgs.yaziPlugins; {
        drag = drag;
        git = git;
        gvfs = gvfs;
        smart-enter = smart-enter;
      };
    };
  };
}
