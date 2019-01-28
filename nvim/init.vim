" Install vim-plug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

" Plugins
call plug#begin()
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'morhetz/gruvbox'
  Plug 'scrooloose/nerdtree'
  Plug 'w0rp/ale'
  Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --ts-completer' }
  Plug 'tpope/vim-surround'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
call plug#end()

let g:airline_powerline_fonts = 1
let mapleader = ','

" Configure ale
let g:ale_fixers = {
      \  '*': ['trim_whitespace', 'remove_trailing_lines'],
      \  'javascript': ['eslint']
      \}
let g:ale_fix_on_save = 1

" Configure ctrlp
let g:ctrlp_user_command="fd"

" === Settings ===
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·
set autoread
set nowrap
set number
set undolevels=1000
set history=1000
set incsearch
set smartcase
set ignorecase
set hidden
set nobackup
set noswapfile
set nowb
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

colorscheme gruvbox

" Mappings
nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Esc> :noh<CR>

" Open NERDTree with `vim`
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
