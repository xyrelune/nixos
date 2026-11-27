{
  self,
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.zsh = moduleWithSystem ({
    config,
    pkgs,
    self',
    ...
  }: { 
      config = {
        nixpkgs.overlays = [
          (final: prev: {
            zsh = self'.packages.zsh;
          })
        ];
        programs.zsh = {
          enable = true;
          enableCompletion = true;
        };
        users.users.kin.shell = pkgs.zsh;
      };
  });
  perSystem =  {
    lib,
    pkgs,
    ...
  }: {
    packages.zsh = inputs.wrapper-modules.wrappers.zsh.wrap {
      inherit pkgs;
      zshAliases = {
        nrs = "sudo nixos-rebuild switch --flake /home/kin/nixos/#$(hostname)";
        y = lib.getExe pkgs.yazi;
        ls = "${lib.getExe pkgs.lsd} -l";
        la = "${lib.getExe pkgs.lsd} -a";
        lla = "${lib.getExe pkgs.lsd} -la";
        lt = "${lib.getExe pkgs.lsd} --tree";
        server_rebuild = "nixos-rebuild switch --flake ~/nixos#server --target-host kin@server.lan --build-host kin@server.lan --sudo --ask-sudo-password";
      };
      zshrc.content = ''
        export TERM=xterm-256color
        export SSH_AUTH_SOCK=/home/kin/.bitwarden-ssh-agent.sock

        autoload -Uz vcs_info
        precmd() { vcs_info }
      
        zstyle ':vcs_info:git:*' formats '%b '
      
        setopt PROMPT_SUBST
        PROMPT='(%F{142}%n%f@%F{108}%m%f) [%F{223}%~%f] %(?.%F{142}.%F{167})%#%f '
      '';
    };
  };
}
