{
  self,
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.vim = moduleWithSystem ({
    pkgs,
    lib,
    self',
    ...
  }: {
    programs.vim = {
      enable = true;
      package = self'.packages.myVim;
    };
    environment.systemPackages = [
      pkgs.fzf
      pkgs.fd
      pkgs.ripgrep
    ];
  });
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.myVim = inputs.wrapper-modules.wrappers.vim.wrap {
      inherit pkgs;
      plugins = with pkgs; [
        vimPlugins.fzf-vim
      ];
      vimrc = '' 
        set number
        set cursorline
        set relativenumber
        set termguicolors
        syntax on
        
        set wrap
        set scrolloff=10
        set sidescrolloff=8
        
        filetype plugin indent on
        set tabstop=2
        set shiftwidth=2
        set softtabstop=2
        set expandtab
        set smartindent
        set autoindent
        
        set ignorecase
        set smartcase
        set incsearch
        set hlsearch
        
        set showmatch
        set matchtime=2
        set cmdheight=1
        set completeopt=menuone,noinsert,noselect
        
        set nobackup
        set nowritebackup
        set noswapfile
        set undofile
        set undodir=~/.vim/undodir
        set updatetime=300
        set autoread
        set noautowrite
        
        set hidden
        set noerrorbells
        set backspace=indent,eol,start
        set noautochdir
        set selection=exclusive
        set mouse=a
        set clipboard=unnamedplus
        set modifiable
        set encoding=utf-8
        
        let mapleader = " " 
        nnoremap <leader>cd :Ex<CR>
        nnoremap <leader>ff :Files<CR>
        nnoremap <leader>fo :History<CR>
        nnoremap <leader>fb :Buffers<CR>
        
        nnoremap <leader>fg :Rg<Space>
        
        set laststatus=2
        set background=dark
      '';
    };
  };
}
