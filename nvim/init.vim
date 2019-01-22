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
call plug#end()

let g:airline_powerline_fonts = 1
let mapleader = ','

" Settings
set nowrap
set number
set tabstop=4
set shiftwidth=4
set shiftround
set undolevels=1000
set history=1000
set incsearch
set smartcase
set ignorecase
set hidden
set nobackup
set noswapfile

colorscheme gruvbox

" Mappings
nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Esc> :noh<CR>

