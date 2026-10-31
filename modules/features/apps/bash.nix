{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.bash = {
    lib,
    pkgs,
    ...
  }: let 
    nixosDir = "/home/kin/nixos";
  in {
    programs.bash = {
      enable = true;
      shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake ${nixosDir}#$HOSTNAME";
        hms = "home-manager switch --flake ${nixosDir}#$USER-$HOSTNAME";
        y = "yazi";
        l = "${lib.getExe pkgs.lsd} -l";
        la = "${lib.getExe pkgs.lsd} -a";
        lla = "${lib.getExe pkgs.lsd} -la";
        lt = "${lib.getExe pkgs.lsd} --tree";
        vpn53_start = "sudo systemctl start wg-quick-lenovo.service";
        vpn53_stop = "sudo systemctl stop wg-quick-lenovo.service"; 
        server_rebuild = "nixos-rebuild switch --flake ~/nixos#server --target-host kin@server.lan --build-host kin@server.lan --sudo --ask-sudo-password";
      };
      enableLsColors = true;
      completion.package = pkgs.bash-completion;
    };
  };
}
