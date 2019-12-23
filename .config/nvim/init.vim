syntax on
filetype plugin indent on

let plugpath = '~/.vim/bundle'

" set TERM as a fix for screen and tmux
if has('nvim')
  let plugpath = '~/.local/share/nvim/bundle'
  " if !empty($STY)
  "   let $TERM = 'screen-256color'
  " endif
endif

if has('vim')
  if !empty($STY)
    "let $TERM = 'xterm-256color'
    set term=screen-256color
  endif
endif

" removed for urxvt
"set termguicolors

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
 call plug#begin(plugpath)
   Plug 'git@github.com:tpope/vim-surround.git'
   Plug 'git@github.com:tpope/vim-commentary.git'
   Plug 'git@github.com:vim-syntastic/syntastic.git'
   Plug 'git@github.com:svermeulen/vim-subversive.git'
   Plug 'git@github.com:bronson/vim-trailing-whitespace.git'
   Plug 'git@github.com:vim-airline/vim-airline.git'
   Plug 'neoclide/coc.nvim', {'branch': 'release'}
   Plug 'git@github.com:dense-analysis/ale.git'
   Plug 'udalov/kotlin-vim'
   Plug 'sbdchd/neoformat'
   Plug 'https://github.com/vim-scripts/CycleColor.git'
   Plug 'git@github.com:prettier/vim-prettier.git', { 'do': 'yarn add prettier' }
   Plug 'git@github.com:c-brenn/repel.nvim.git'
   Plug 'git@github.com:scrooloose/nerdtree.git'
   Plug 'git@github.com:rust-lang/rust.vim.git'
   Plug 'git@github.com:dhruvasagar/vim-zoom.git'
if $OS != "Arch Linux"
   Plug 'git@github.com:fsharp/vim-fsharp.git', { 'for': 'fsharp', 'do':  'make fsautocomplete' }
endif
"   Plug 'neovimhaskell/haskell-vim'
"   Plug 'git@github.com:neovimhaskell/haskell-vim.git'
"   Plug 'git@github.com:itchyny/vim-haskell-indent.git'
"   Plug 'git@github.com:terryma/vim-multiple-cursors.git'
"   Plug 'git@github.com:yuttie/comfortable-motion.vim.git'
 call plug#end()

+ " coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-java',
  \ 'coc-git',
  \ 'coc-rls',
  \ 'coc-python',
  \ 'coc-fsharp',
  \ ]

" Show line numbers and relative numbers
set number relativenumber

" Show file statistics
set ruler

" Blink cursor on error instead of beeping
set visualbell

" White space
set wrap
set tabstop=4
set shiftwidth=2
set softtabstop=4
set expandtab
set noshiftround

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" \ is the leader key

" Map leader space clears search
map <leader><space> :let @/=''<cr>

" Map <leader>* to 'search for duplicates of this exact line'
nnoremap <leader>* 0y$/\V<c-r>"<cr>

" Map leader to write a root
noremap <Leader>W :w !sudo tee % > /dev/null

colorscheme evening
"colorscheme 256-jungle
"colorscheme darkblue

" Enable scrolling via mouse
" if has('mouse')
"   set mouse=a
" endif
" disable mouse scrolling?
set mouse-=a

" set gfn=Source\ Code\ Pro:h15

" disable spellcheck
set nospell

" Enable folding
set foldmethod=manual

set tags=tags

" Use 256 colors (Use this setting only if your terminal supports 256 colors)
set t_Co=256
"if ( $TERM == "xterm-256color" || $TERM == "screen-256color" )
  " set t_Co=256
" endif

" Powerline
" set rtp+=/usr/share/powerline/bindings/vim/
" set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim
" set rtp+=~/.local/lib/python3.7/site-packages/powerline/bindings/vim
" set rtp+=~/.local/lib/python3.6/site-packages/powerline/bindings/vim
" set rtp+=~/.local/lib64/python3.6/site-packages/powerline/bindings/vim

" Always show statusline
set laststatus=2

" Disable Arrow keys in NORMAL mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in INSERT mode
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>

if exists(":PrettierAsync")
  let g:prettier#autoformat = 0
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
endif

autocmd BufNewFile,BufRead .xinitrc set filetype=sh
autocmd BufNewFile,BufRead xmobarrc set filetype=haskell
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead Berksfile set filetype=ruby
"autocmd BufWritePre .zshrc %s/\s\+$//e
if exists(":FixWhitespace")
  autocmd BufWritePre .zshrc,*.sql,*.sh,*.json FixWhitespace
endif

let g:haskell_enable_quantification = 1

" normal mode Easy filetype switching
nnoremap ftm :set ft=markdown<cr>
nnoremap ftp :set ft=python<cr>
nnoremap ftw :set ft=wiki<cr>
nnoremap ftr :set ft=ruby<cr>
nnoremap ftrs :set ft=rst<cr>
nnoremap ftv :set ft=vim<cr>
nnoremap ftj :set ft=javascript<cr>
nnoremap fts :set ft=sql<cr>
nnoremap ftsh :set ft=sh<cr>
nnoremap ftc :set ft=css<cr>
nnoremap fth :set ft=html<cr>
" "nmap ,md :set ft=markdown<cr>

" normal mode mapings
nmap <leader>z :g/^$/d<cr>
nmap <leader>s :%s/\s\+$//g<cr>
nmap <leader>l :set nu! rnu!<cr>

" normal mode: edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>ez :vsp ~/.zshrc<cr>

" find file in NERDTree
nnoremap <Leader>f :NERDTreeToggle<cr>

" insertmode: jk is escape
inoremap jk <esc>

" normal mode
noremap  <f1> :colorscheme torte<cr>:set nu! rnu!<cr>:Sopen ghci<cr>

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType vim              let b:comment_leader = '" '
autocmd FileType make,snippets set noexpandtab shiftwidth=8 softtabstop=0

" fsharp file set based on .fs
autocmd BufNewFile,BufRead *.fs :set filetype=fsharp

" noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
" noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" :checkhealth
" python2 -m pip uninstall neovim pynvim
" python3 -m pip uninstall neovim pynvim
" python3 -m pip install --user --upgrade pynvim
" python2 -m pip install --user --upgrade pynvim
" https://github.com/neovim/neovim/blob/master/runtime/doc/provider.txt
"let g:loaded_python_provider = 0
"let g:loaded_python3_provider = 0
"let g:python3_host_prog = '/usr/bin/python3'
"let g:python2_host_prog = '/usr/bin/python2'
"let g:fsharp_interactive_bin = '/opt/dotnet/sdk/2.2.108/FSharp/fsi.exe'

" for rust
let g:rustfmt_autosave = 1

set exrc " allows loading local executing local rc files
set secure " disallows the use of :autocmd, shell and write commands

set cursorline
" override the cursor settings
hi CursorLine cterm=NONE ctermbg=black ctermfg=NONE

" override settings for evening theme
" hi Normal ctermbg=236 ctermfg=White guifg=White guibg=grey20

" could this setting work
" set t_Co=88
