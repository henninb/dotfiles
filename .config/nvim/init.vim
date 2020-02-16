syntax on
filetype plugin indent on

let plugpath = '~/.vim/bundle'

if has('nvim')
  let plugpath = '~/.config/nvim/bundle'
endif

if has('vim')
  if !empty($STY)
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

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if ! empty(glob('~/.config/coc/extensions/node_modules/coc-pairs'))
  autocmd CocUninstall coc-pairs
endif
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
 call plug#begin(plugpath)
   Plug 'git@github.com:tpope/vim-surround.git'
   Plug 'git@github.com:tpope/vim-commentary.git'
   Plug 'git@github.com:vim-syntastic/syntastic.git'
   Plug 'git@github.com:svermeulen/vim-subversive.git' " search and replace tool
   Plug 'git@github.com:bronson/vim-trailing-whitespace.git' " remove trailing whitespace
   Plug 'git@github.com:vim-airline/vim-airline.git'
   Plug 'neoclide/coc.nvim', {'branch': 'release'}
   Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
   Plug 'git@github.com:dense-analysis/ale.git' " linter
   Plug 'sbdchd/neoformat' " for formatting code
   " Plug 'https://github.com/vim-scripts/CycleColor.git'
   " Plug 'git@github.com:prettier/vim-prettier.git', { 'do': 'yarn add prettier' }
   Plug 'git@github.com:c-brenn/repel.nvim.git'
   Plug 'git@github.com:scrooloose/nerdtree.git'
   Plug 'Xuyuanp/nerdtree-git-plugin'
   Plug 'git@github.com:dhruvasagar/vim-zoom.git'
   Plug 'git@github.com:easymotion/vim-easymotion.git' " improvements for motions
   Plug 'git@github.com:tpope/vim-fugitive.git'  " for git
   Plug 'norcalli/nvim-colorizer.lua' " tool to show colors in vim r,g,b
   Plug 'tpope/vim-abolish'
   Plug 'MikeCoder/quickrun.vim'
   " Plug 'dracula/vim', { 'name': 'dracula' }  " theme
   Plug 'benmills/vimux' " tmux integration
   Plug 'git@github.com:alvan/vim-closetag.git' "closing tags for html
   Plug 'git@github.com:rust-lang/rust.vim.git'
   Plug 'udalov/kotlin-vim'
   Plug 'git@github.com:neovimhaskell/haskell-vim.git'
   Plug 'git@github.com:fsharp/vim-fsharp.git', { 'for': 'fsharp', 'do':  'make fsautocomplete' }
   " Plug 'jiangmiao/auto-pairs' " used for auto closing quotes etc
"   Plug 'neovimhaskell/haskell-vim'
"   Plug 'git@github.com:itchyny/vim-haskell-indent.git'
"   Plug 'git@github.com:terryma/vim-multiple-cursors.git'
"   Plug 'git@github.com:yuttie/comfortable-motion.vim.git'
"   Plug 'git@github.com:morhetz/gruvbox.git'
 call plug#end()

" coc config
" CocCommand git.toggleGutters
" :CocUninstall coc-pairs
"  \ 'coc-pairs',
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-java',
  \ 'coc-git',
  \ 'coc-rls',
  \ 'coc-python',
  \ 'coc-fsharp',
  \ ]

autocmd FileType markdown let b:coc_pairs_disabled = ['`']
autocmd FileType vim let b:coc_pairs_disabled = ['"']

let g:quickrun_known_file_types = {
  \"cpp": ["!g++ %", "./a.out"],
  \"c": ["!gcc %", "./a.out"],
  \"vim": ["source %"],
  \"py": ["!python %"],
  \"go": ["!go %"],
  \}

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,js'

" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" open NERDTree automatically
" autocmd VimEnter * NERDTree

" Enable spell checking, s for spell check
map <leader>s :setlocal spell! spelllang=en_us<cr>

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
" space key is the leader key
let mapleader=" "

" Map leader space clears search
map <leader><space> :let @/=''<cr>

" Map <leader>* to 'search for duplicates of this exact line'
nnoremap <leader>* 0y$/\V<c-r>"<cr>

" Map leader to write a root
noremap <leader>W :w !sudo tee % > /dev/null

"colorscheme evening
"colorscheme 256-jungle
"colorscheme darkblue
colorscheme dracula

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

" Use 256 colors
set t_Co=256

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

" disable arrow keys in VISUAL mode
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

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
  autocmd BufWritePre .zshrc,*.sql,*.sh,*.json,.vimrc FixWhitespace
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
" remove trailing spaces
" nmap <leader>s :%s/\s\+$//g<cr>
" toggle line numbers
nmap <leader>l :set nu! rnu! list!<cr> :CocCommand git.toggleGutters<cr>
" toggle nerd tree
nmap <leader>n :NERDTreeToggle<cr>
"space separated to column
nmap <leader>c :s/\s\+/\r/g<cr>
nmap <leader>C :s/\s\+/\r/g<cr> :sort<cr>

" normal mode: edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>ez :vsp ~/.zshrc<cr>

" insertmode: jk is escape
inoremap jk <esc>

" normal mode
noremap  <f1> :colorscheme torte<cr>:set nu! rnu!<cr>:Sopen ghci<cr>

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType vim              let b:comment_leader = '" '
"autocmd FileType make,snippets set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType make,snippets set noexpandtab shiftwidth=4 softtabstop=0

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

set ffs=unix
set encoding=utf-8
set fileencoding=utf-8
"set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵
set listchars=eol:¬,tab:»·,trail:␠,nbsp:⎵

"set listchars=eol:¬
"set listchars+=tab:».
"set listchars+=tab:->
set list

" center on motions
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz


" <leader>f{char} to move to {char}
map  <leader>f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-overwin-f)

map <F2> :.w !pbcopy<cr><cr>
map <F3> :r !pbpaste<cr>

"let g:python_host_prog = '/full/path/to/neovim2/bin/python'
"let g:python3_host_prog = '/full/path/to/neovim3/bin/python'
"
" Shortcutting split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" close a window
map <C-c> <C-w>c

" Shortcut split opening
nnoremap <leader>h :split<cr>
nnoremap <leader>v :vsplit<cr>

autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"
autocmd VimLeave * silent exec "! echo -ne '\e[5 q'"
