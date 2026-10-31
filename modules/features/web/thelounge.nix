{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.thelounge = {
    pkgs,
    ...
  }: {
    services.thelounge = {
      enable = true;
      extraConfig = {
        defaults = {
          nick = "cujo1337";
          username = "cujo1337";
          realname = "cujo1337";
        };
      };
    };
  };
}
