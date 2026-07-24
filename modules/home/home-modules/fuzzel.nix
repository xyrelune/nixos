{
  self,
  inputs,
  ...
}: {
  flake.homeModules.fuzzel = {
    pkgs,
    ...
  }: {
    programs.fuzzel = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myFuzzel;
    };
  };
  perSystem = {
    pkgs,
    ...
  }: {
    packages.myFuzzel = inputs.wrapper-modules.wrappers.fuzzel.wrap {
      inherit pkgs;
      settings = {
        main = {
          #font = "Futura:size=12";
          list-executables-in-path = "yes";
        };
        colors = {
          background = "1f1f28ff";
          text = "dcd7baff";
          match = "ffa066ff";
          selection = "2a2a37ff";
          selection-match = "e6c384ff";
          selection-text = "dcd7baff";
          border = "54546dff";
        };
      };
    };
  };
}
