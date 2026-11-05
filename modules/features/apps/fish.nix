{
  self,
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.fish = moduleWithSystem ({
    lib,
    pkgs,
    self',
    ...
  }: {
    programs.fish = {
      enable = true;
      package = self'.packages.myFish;
    };
  });
  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    packages.myFish = inputs.wrapper-modules.wrappers.fish.wrap {
      inherit pkgs;
      abbreviations = {
        nrs = "sudo nixos-rebuild switch --flake /home/kin/nixos#laptop";
        y = "yazi";
        l = "${lib.getExe pkgs.lsd} -l";
        la = "${lib.getExe pkgs.lsd} -a";
        lla = "${lib.getExe pkgs.lsd} -la";
        lt = "${lib.getExe pkgs.lsd} --tree";
        vpn53_start = "sudo systemctl start wg-quick-lenovo.service";
        vpn53_stop = "sudo systemctl stop wg-quick-lenovo.service"; 
        server_rebuild = "nixos-rebuild switch --flake ~/nixos#server --target-host kin@server.lan --build-host kin@server.lan --sudo --ask-sudo-password";
      };
    };
  };
}
