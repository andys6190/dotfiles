set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

let $GIT_SSL_NO_VERIFY = 'true'

Plugin 'VundleVim/Vundle.vim'
Plugin 'gmarik/vundle'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'JumpToLastOccurrence'
Plugin 'tpope/vim-surround'
Plugin 'Lokaltog/powerline'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-eunuch'
Plugin 'vim-scripts/taglist.vim'
Plugin 'tpope/vim-ragtag'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-abolish'
Plugin 'fatih/vim-go'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'othree/yajs.vim'

" Syntax highlighting plugins
Plugin 'leafgarland/typescript-vim'
Plugin 'scrooloose/syntastic'
Plugin 'groenewege/vim-less'
Plugin 'chrisbra/csv.vim'
Plugin 'xsbeats/vim-blade'
Plugin 'digitaltoad/vim-jade'
Plugin 'nono/vim-handlebars'

call vundle#end()

filetype plugin indent on     " required!

" ================ General Config ====================
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set hidden                      "Allows switching buffers without first saving
set autochdir                   "Automatically change pwd to that of the currently open file
set paste                       "Do not add tabs when pasting into vim

let mapleader = ","

runtime macros/matchit.vim      "Allows `%` to jump between if/else, xml tags

syntax on

let &t_Co=256
let g:desert_termcolors=256
colorscheme solarized
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set background=dark
"set guifont=Menlo:h14
set smartindent
set autoindent
set hidden
set hlsearch
set incsearch
"set foldmethod=indent
"set foldnestmax=10
set foldenable
"set foldlevel=1
set tw=120
set fo-=t
set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points
set colorcolumn=120
highlight ColorColumn ctermbg=black guibg=black
highlight Normal ctermbg=black
set ignorecase 
set smartcase
set notitle
set ruler

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

set nobackup
set nowritebackup

" set backupdir=~/.vim/backup/
" set directory=~/.vim/backup/
"
" personal key mappings
nmap <F2> :Definer<CR>

" ============= NERDTree Mappings ===================
nmap <LEADER>nt :NERDTreeTabsToggle
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
" let g:nerdtree_tabs_open_on_console_startup=1

" ============ Syntastic Configuration ===============
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']

" ================== Key Mappings ===================
:imap jj <Esc> " jj to exit insert mode

" ================== React ===================
let g:jsx_ext_required = 0 " Allo jsx in normal js files

" =====================================================
" Preserves cursor and history state when running a command
function! <SID>Preserve(command)
    let _s=@/
    let l = line(".")
    let c = col(".")
    execute a:command
    let @/=_s
    call cursor(l, c)
endfunction

if has("autocmd")
    " Strip trailing whitespace on file save.
    autocmd BufWritePre *.py,*.js,*.php,*.css,*.html,*.ctp,*.less,*.java,*.xml,*.json :call <SID>Preserve('%s/\s\+$//e')

    " Reload this configuration file on save. After a few saves this sometimes causes vim to hang on a mac.
    autocmd bufwritepost .vimrc,vimrc source $MYVIMRC

    " Auto switch between relative and absolute line numbers
    autocmd InsertEnter * :set number
    autocmd InsertLeave * :set relativenumber

" autocmd VimEnter * NERDTree
" autocmd BufEnter * NERDTreeMirror
endif

"Powerline {
"    python import sys; sys.path.append("/Users/rob/Library/Python/2.7/lib/python/site-packages")
    set encoding=utf-8              " Necessary to show Unicode glyphs
    "let g:Powerline_symbols = 'fancy'
    set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
    set laststatus=2 " Always display the statusline in all windows
    set noshowmode
    if has('gui_running')
        if has("gui_gtk2")
            set guifont=Monaco\ for\ Powerline:h12
        else
            set guifont=Menlo\ for\ Powerline:h12
        endif
    else
        set t_Co=256
    endif
"}

"CtrlP {
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlPBuffer'

    " Use <c-@> to close open buffers while in ctrlp
    let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

    func! MyCtrlPMappings()
        nnoremap <buffer> <silent> <c-@> :call <sid>DeleteBuffer()<cr>
    endfunc

    func! s:DeleteBuffer()
        let line = getline('.')
        let bufid = line =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(line, '\d\+'))
            \ : fnamemodify(line[2:], ':p')
        exec "bd" bufid
        exec "norm \<F5>"
    endfunc
"}

" Javascript syntax highlighting for Titanium Alloy style sheets.sheets
if has('autocmd')
    au BufRead *.tss set filetype=javascript
endif

"Airline {
"    let g:airline#extensions#tabline#enabled = 1
"    let g:airline_powerline_fonts = 1
"}

