let need_to_install_plugins = 0
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
    let need_to_install_plugins = 1
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim', {'as':'dracula'}
call plug#end()

if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PlugInstall
    echo "Done!"
    q
endif
let mapleader = ","
set number
set softtabstop=4
autocmd FileType make setlocal noexpandtab
autocmd FileType * set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
set hidden
set nowrap
set scrolloff=8
set sidescroll=8
set sidescrolloff=8
set hlsearch
set showcmd
set showmatch
set smartcase
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set list
set listchars=tab:▸\ ,trail:·
inoremap jj <esc>
nnoremap <space> :
nnoremap o o<esc>
nnoremap O O<esc>
nnoremap n nzz
nnoremap N Nzz
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
color dracula
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
highlight Visual term=reverse cterm=reverse guibg=Grey
highlight Search term=reverse cterm=reverse guibg=Grey

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

vnoremap <leader>c "+y
vnoremap <leader>C "+yg_
nnoremap <leader>c "+y

nnoremap <leader>v "+p
nnoremap <leader>V "+P
vnoremap <leader>v "+p
vnoremap <leader>V "+P

nnoremap <leader>x :bd<CR>

nnoremap <c-f> :FZF<CR>

nnoremap <c-s> :w<CR>
noremap <c-s> :w<CR>
vnoremap <c-s> <Esc>:w<CR>
inoremap <c-s> <Esc>:w<CR>

" Allow gf to open non-existent files
map gf :edit <cfile><CR>

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" disable autoindent when pasting text
" source:
" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"


" Hightlight on yank
" From https://neovim.io/news/2021/07
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

" airline tuning
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#fzf#enabled = 1

let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

