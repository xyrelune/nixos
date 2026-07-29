{
  self,
  inputs,
  ...
}: {
  flake.homeModules.librewolf = {
    programs.librewolf = {
      enable = true;
    };
  };
}
