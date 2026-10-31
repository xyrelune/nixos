{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.tmux = {
    pkgs,
    ...
  }: { 
    programs.tmux = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myTmux;
    };
  };
  perSystem = {
    pkgs,
    ...
  }: {
    packages.myTmux = inputs.wrapper-modules.wrappers.tmux.wrap {
      inherit pkgs;
      configAfter = ''
        set -g default-terminal "tmux-256color"
        set -ga terminal-overrides ",*:RGB"
        set -g mouse on
        set -g set-clipboard on
        
        unbind C-b 
        set -g prefix C-a 
        bind-key C-a send-prefix
        
        unbind %
        bind v split-window -h -c "#{pane_current_path}"
        
        unbind '"'
        bind s split-window -v -c "#{pane_current_path}"
        
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on
        
        set-window-option -g mode-keys vi 
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangular-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
        unbind -T copy-mode-vi MouseDragEnd1Pane
        
        bind -n C-M-h select-pane -L 
        bind -n C-M-j select-pane -D 
        bind -n C-M-k select-pane -U 
        bind -n C-M-l select-pane -R 
        
        bind -n C-M-x kill-pane
        bind -n C-M-q display-panes
        
        bind -n C-M-c new-window
        bind -n S-Left previous-window
        bind -n S-Right next-window 
      '';
    };
  };
}
