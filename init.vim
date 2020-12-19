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

filetype indent plugin off
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
Plug 'sbdchd/neoformat'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Initialize plugins
call plug#end()

filetype indent plugin off
syntax off
set showcmd
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

noremap <silent> <leader>' :NERDTreeFind<CR>
noremap <silent> <leader>z :NERDTreeToggle<CR>

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
set wildignore+=**/node_modules/*,**/vendor/*,**/target/*,**/dist/*
set mouse=

set backup
set backupdir=/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=/tmp
set writebackup

if (has("termguicolors"))
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

	" fixes glitch? in colors when using vim with tmux
	set background=light
	set t_Co=256
endif

highlight LineNr guifg=#aaaaaa ctermfg=gray
highlight NonText guifg=#aaaaaa
highlight CursorLineNr cterm=NONE ctermbg=NONE ctermfg=140 guibg=NONE guifg=140
highlight MatchParen cterm=NONE ctermbg=NONE ctermfg=red guibg=NONE guifg=red
highlight Special cterm=NONE ctermfg=red guifg=red ctermbg=NONE guibg=NONE
highlight Statement cterm=NONE ctermfg=red guifg=red ctermbg=NONE guibg=NONE
highlight Type cterm=NONE ctermfg=red guifg=red ctermbg=NONE guibg=NONE
highlight Underlined ctermfg=red guifg=red ctermbg=NONE guibg=NONE
highlight Question ctermfg=red guifg=red ctermbg=NONE guibg=NONE
highlight MoreMsg ctermfg=red guifg=red ctermbg=NONE guibg=NONE
highlight StatusLineNC gui=none cterm=none guibg=gray ctermbg=gray guifg=black ctermfg=black
highlight StatusLine gui=reverse cterm=reverse
highlight Search gui=none cterm=none guifg=#ff6600 guibg=none ctermfg=yellow ctermbg=none
highlight Visual gui=none cterm=none guifg=black guibg=a790d5 ctermfg=black ctermbg=140
highlight Pmenu gui=none cterm=none guifg=white guibg=red ctermfg=white ctermbg=red
highlight TODO gui=none cterm=none guifg=black guibg=orange ctermfg=white ctermbg=red

if has('nvim')
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

let g:neoformat_try_formatprg = 1

augroup NeoformatAutoFormat
    autocmd!
    autocmd FileType javascript,javascript.jsx setlocal formatprg=prettier\ --tab-width\ 4\ --jsx-bracket-same-line\ --print-width\ 120\ --single-quote\ --parser\ babel\ --trailing-comma\ none
    autocmd FileType css setlocal formatprg=prettier\ --tab-width\ 4\ --jsx-bracket-same-line\ --print-width\ 120\ --single-quote\ --parser\ css
    autocmd FileType vue setlocal formatprg=prettier\ --tab-width\ 4\ --jsx-bracket-same-line\ --print-width\ 120\ --single-quote\ --parser\ vue
    autocmd FileType svelte setlocal formatprg=prettier\ --tab-width\ 4\ --jsx-bracket-same-line\ --print-width\ 120\ --single-quote\ --plugin-search-dir=/home/dak0rn/.npm-global/lib\ --parser\ svelte
    autocmd FileType go setlocal formatprg=gofmt
    autocmd BufWritePre *.svelte,*.js,*.jsx,*.css,*.vue,*.go Neoformat
augroup END
	
au BufNewFile,BufRead *.vue set filetype=vue
au BufNewFile,BufRead *.svelte set filetype=svelte

augroup HighlightTODO
	autocmd!
	autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
augroup END

" Configure the status line
set laststatus=2
set statusline=%f\ %m%r%=%l/%L

"FZF configuration
let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,vendor,yarn.lock}"'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "!{.git,node_modules,vendor,yarn.lock}" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

noremap <silent> <leader>; :Files<CR>
noremap <silent> <leader>. :Rg<CR>
noremap <silent> <leader>l :Buffers<CR>
noremap <silent> <leader>k :BLines<CR>

" Disable comment continuiation
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

let g:NERDTreeNodeDelimiter = "\u00a0"

au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

