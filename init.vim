" We want to use KSH
set shell=ksh

" FZF is set up with rg
" Ensure we have that
if ! executable("rg")
	echo "Cannot find executable 'rg' in $PATH\n"
	call getchar(1)
endif

" Detect the editor used
if has("nvim")
    let s:editor_dir=expand("~/.config/nvim")
else
    let s:editor_dir=expand("~/.vim");
endif

filetype plugin indent on
let s:plug_file=s:editor_dir . "/autoload/plug.vim"

" Install vim-plug if it is not already installed
if !filereadable(s:plug_file)
    echo "Installing vim-plug..."
    echo "**********************"
    execute "!curl -fLo " . s:plug_file . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    " Automatically installed defined plugins
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let &rtp .= ',' . s:plug_file

" Start vim-plug
call plug#begin(s:editor_dir . "/plugged")

Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'SirVer/ultisnips'
Plug 'sbdchd/neoformat'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Initialize plugins
call plug#end()

filetype plugin indent off
set showcmd
syntax off
set wildmenu
set smartindent

set ignorecase
set smartcase

set shiftwidth=4
set tabstop=4
set noexpandtab

set smarttab

set rnu nu
set nowrap
set fo-=t

noremap j gj
noremap k gk
noremap Y y$
vnoremap < <gv
vnoremap > >gv

" Turn off arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Right> <NOP>
noremap <Left> <NOP>

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Right> <NOP>
inoremap <Left> <NOP>

" Easier split switching
noremap <C-j> <C-W><C-J>
noremap <C-h> <C-W><C-H>
noremap <C-k> <C-W><C-K>
noremap <C-l> <C-W><C-L>

let mapleader = ','

noremap <silent> H :nohl<CR>

noremap <silent> <leader>' :NERDTreeToggle<CR>

vnoremap <C-c> <Esc>
inoremap <C-c> <Esc>

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

set backspace=2
set showmode
set nocursorline
scriptencoding utf-8

set incsearch
set hlsearch
set listchars=tab:\ \ ,trail:•
set list

nnoremap gV `[v`]

set splitright
set splitbelow
set wildignore+=**/bower_components/*,**/node_modules/*,**/vendor/*,**/target/*
set mouse=

set backup
set backupdir=/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=/tmp
set writebackup

if (has("termguicolors"))
 set termguicolors
endif

highlight LineNr guifg=#aaaaaa
highlight NonText guifg=#aaaaaa
highlight CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
highlight MatchParen cterm=NONE ctermbg=NONE ctermfg=red guibg=NONE guifg=red

if has('nvim')
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

let g:neoformat_try_formatprg = 1

augroup NeoformatAutoFormat
    autocmd!
    autocmd FileType javascript,javascript.jsx setlocal formatprg=prettier\ --stdin\ --tab-width\ 4\ --jsx-bracket-same-line\ --print-width\ 120\ --single-quote
    autocmd BufWritePre *.js,*.jsx,*.css Neoformat
augroup END

" Configure the status line
set laststatus=2
set statusline=%f\ %m%r%=%l/%L

"FZF configuration
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

noremap <silent> <leader>; :Files<CR>
noremap <silent> <leader>. :Rg<CR>

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
