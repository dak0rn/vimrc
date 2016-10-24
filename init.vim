" Vundle setup
filetype off

" Detect the type of vim used here
if has('nvim')
    let s:editor_dir=expand("~/.config/nvim")
else
    let s:editor_dir=expand("~/.vim")
endif

" State flags
let s:v_installed=1
let s:v_readme=s:editor_dir . '/bundle/Vundle.vim/README.md'

" Check if Vundle has already been cloned locally
if !filereadable(s:v_readme)
    echo "Installing vundle..."
    echo ""
    silent call mkdir(s:editor_dir . '/bundle', 'p')
    silent execute "!git clone https://github.com/VundleVim/Vundle.vim " . s:editor_dir . "/bundle/Vundle.vim"
    let s:v_installed=0
endif

" Update the runtime path correctly
let &rtp .= ',' . s:editor_dir . '/bundle/Vundle.vim'

" Start vundle
call vundle#begin(s:editor_dir . '/bundle')

" Vundle plugins
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'othree/yajs.vim'
Bundle 'mxw/vim-jsx'
" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-commentary'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'metakirby5/codi.vim'
Plugin 'takac/vim-hardtime'
Plugin 'sotte/presenting.vim'
Plugin 'jacoborus/tender'
Plugin 'oblitum/rainbow'

" Install plugins if vundle has just been installed
if s:v_installed == 0
    :PluginInstall
endif

call vundle#end()

" Filetype detection
filetype plugin indent on
" Display commands at the bottom of the screen
set showcmd

" Syntax highlighting
syntax on

" Use a menu for auto completion of files and folders
set wildmenu

" Automatic indentation
set smartindent

" Smart case matching
set ignorecase
set smartcase

" Tab width: four characters
set shiftwidth=4
set tabstop=4

" Spaces are better than tabs
set expandtab

" Smart identation
set smarttab

" Line numbers and length
set rnu nu      " Use relative line numbering and show the current line number
set nowrap      " Do not wrap on load
set fo-=t       " Do not wrap when typing

" Instead of using colorcolumn and textwidth
" we use this little snippet
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>120v.\+', -1)

" Better moving
noremap j gj
noremap k gk

" Yank to eol like C, S or D do
noremap Y y$

" Better indentation in visual mode
vnoremap < <gv
vnoremap > >gv

" Moving with B / E feels better than with ^/$
noremap B ^
noremap E $
noremap ^ <nop>
noremap $ <nop>

" We do not use arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Right> <NOP>
noremap <Left> <NOP>

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Right> <NOP>
inoremap <Left> <NOP>

" Make split switching easier
noremap <C-j> <C-W><C-J>
noremap <C-h> <C-W><C-H>
noremap <C-k> <C-W><C-K>
noremap <C-l> <C-W><C-L>

" Trigger CtrlP search with \tt
noremap <silent> <leader>tt :CtrlP<CR>

" I used to press <C-c> to exit a mode but this is not
" quite the same as using <Esc>. Therefore it's remapped.
vnoremap <C-c> <Esc>
inoremap <C-c> <Esc>
inoremap <Esc> <nop>
vnoremap <Esc> <nop>

" Settings for CtrlP
let g:ctrlp_switch_buffer=0
let g:ctrlp_working_path_mode=0
" Use ag to find files
let g:ctrlp_user_command='ag %s -l --nocolor -g ""'

" Status line
set laststatus=2

" Right aligned: git status, modified flag, filename w/out path
set statusline=%=%{fugitive#statusline()}\ %m\ %t

" Hide background color
hi StatusLine ctermbg=NONE cterm=NONE

" Show diff for unsaved changes
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis

    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
noremap <leader>d :DiffSaved<CR>

" Make backspace very awesome
set backspace=2

" Show current mode
set showmode

" Don't highlight current line
set nocursorline

" We want to use UTF-8
scriptencoding utf-8

" Find as you type search
set incsearch

" Highlight search results
set hlsearch

" Trailing space character is that fancy dot
set listchars=trail:•
" Show whitespace characters
set list

" Select the last insert
nnoremap gV `[v`]

" Split on right and on bottom
set splitright
set splitbelow

" Things to ignore when searching, e.g. with CtrlP
set wildignore+=**/bower_components/*,**/node_modules/*,**/vendor/*,**/target/*

" Disable mouse
set mouse=

" Backup settings
set backup
set backupdir=/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=/tmp
set writebackup

" Enable hard mode by default
let g:hardtime_default_on = 1

if (has("termguicolors"))
 set termguicolors
endif

colorscheme tender

let g:rainbow_active = 1
