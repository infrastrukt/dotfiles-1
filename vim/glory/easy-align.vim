" vim options {{{

" add truecolor support, if available
if has('termguicolors')
  set termguicolors
endif

" cursor shape config {{{

" escape sequence: `^[]1337;CursorShape=N^G`. where:
" N=0: block;
" N=1: line;
" N=2: underline;
" ^G = \x7
" ˆ[ = \e
" more info here http://www.iterm2.com/documentation-escape-codes.html
" better cursor shape for vim in terminal (works with iTerm2)
" see: https://www.iterm2.com/documentation-escape-codes.html
" SI = START insert mode
" EI = END insert mode
" SR = START replace mode

if empty($TMUX)
  let &t_SI = "\<Esc>]1337;CursorShape=1\x7"
  let &t_EI = "\<Esc>]1337;CursorShape=0\x7"
  let &t_SR = "\<Esc>]1337;CursorShape=2\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]1337;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]1337;CursorShape=0\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]1337;CursorShape=2\x7\<Esc>\\"
endif

" }}}

syntax on

" backups
set nobackup
set nowritebackup
set noswapfile

" better '/'
set incsearch
set hlsearch
set ignorecase

" convert tabs to spaces
set expandtab
set tabstop=2
set shiftwidth=2

set history=100

" diff options. without this Gdiff was splitting horizontally on OSx.
set diffopt=filler,vertical

" show partial commands from operator pending mode
set showcmd

" show line numbers on status line
set ruler

" with this option on, a buffer is marked as ‘hidden’ if it has unsaved changes, and it is not currently loaded in a window.
" If you try and quit Vim while there are hidden buffers, you will raise an error:
" E162: No write since last change for buffer “a.txt”
set hidden

" fix backspace behaviour
set backspace=indent,eol,start

" show trailing spaces
set list listchars=tab:\ \ ,trail:·

" Get rid of the delay when pressing O (for example)
" http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
set timeout timeoutlen=1000 ttimeoutlen=100

" Always show status bar
set laststatus=2

" Hide the toolbar
set guioptions-=T

" Autoload files that have changed outside of vim
set autoread

" http://stackoverflow.com/questions/8134647/copy-and-paste-in-vim-via-keyboard-between-different-mac-terminals
" better gui clipboard integration
set clipboard+=unnamed

" Don't show intro
set shortmess+=I

" better splits
set splitbelow
set splitright

" Highlight the current line
set cursorline

" Visual autocomplete for command menu (e.g. :e ~/path/to/file)
" partially lifted from http://stackoverflow.com/a/15583861/4921402
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*/.hg/*,*/.svn/*.,*/.DS_Store,*/.idea/*,*/.tmp/*,*/target/*

" highlight a matching [{()}] when cursor is placed on start/end character
set showmatch

" do not wrap long lines
set nowrap

" indicates a wrap line continuation
set showbreak=←←

" redraw only when we need to (i.e. don't redraw when executing a macro)
set lazyredraw

" syntax/sh.vim adds `.` to iskeyword(verify with :verbose set iskeyword?). so `w` jumps past it. see :h g:sh_isk
let g:sh_noisk=1

let g:netrw_banner      = 0
let g:netrw_bufsettings = 'relativenumber, number'
let g:netrw_liststyle   = 1
" let g:netrw_keepdir   = 0

filetype plugin indent on

" }}}
" plugins {{{

call plug#begin('~/.vim/plugged')

" plugin configuration {{{

" rainbow configs {{{

let g:rainbow_active = 1

" }}}
" vim-multiple-cursors {{{

let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0

" }}}

" }}}

" theme plugins
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
" Plug 'edkolev/tmuxline.vim'

" core
Plug 'bronson/vim-visual-star-search'
Plug 'chaoren/vim-wordmotion'
Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'luochen1990/rainbow'
Plug 'ninrod/vim-multiple-cursors'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'

call plug#end()

" }}}
" theme configuration {{{

" less eye strain
set background=dark

" gruvbox {{{

" must be set before invoking colorscheme
" gruvbox inverted selection is too much information to me
" plus, the inverted select does not
" play nicely with vim-multiple-cursors
let g:gruvbox_invert_selection=0

silent! colorscheme gruvbox

" see https://github.com/neovim/neovim/issues/4946
" 124 = gruvbox red
highlight SpecialKey ctermfg=124 guifg=#cc241d                            	

" }}}
" lightline.vim {{{

let g:lightline = {
      \'colorscheme': 'gruvbox'
      \}

" }}}
" tmuxline.vim {{{

let g:tmuxline_powerline_separators = 0

" }}}


" }}}
" binds {{{

" standard bind changes {{{

" core binds {{{

" space is my leader key, but '\' remains as leader.
nmap <Space> <Leader>
omap <Space> <Leader>
xmap <Space> <Leader>

nnoremap <silent>- :noh<cr>
xnoremap <silent>- :noh<cr>

nnoremap <cr> :w<cr>

" `cl` is a complete substitute for `s` (also note that `cc` replaces `S`)
nnoremap <silent> s :silent! normal za<cr>

nnoremap Q q
nnoremap q ZQ

" }}}
" g prefix abuse {{{

" custom pageups and pagedowns (you use F12 in intellij, right? so don't come with mnemonic bullshit.)
" Just kidding. note that 0 is below `)` with could mean "right" or "below" or "forward"
" likewise 9 is below `(` with could (mean) "left" or "above" or "backwards"
" there's your mnemonic
nnoremap g0 LztM
nnoremap g9 Hz-M

" trying out gl for `G` (shift sucks)
" basically: `go` goes to the first line. `gl` goes to the last line
" btw: `go` is built in
nnoremap gl G
vnoremap gl G
onoremap gl G

" These <Plug> are not from a plugin
" They come from functions I wrote below. See the `functions section`
nmap g<space> <Plug>(blankUp)
nmap g<cr> <Plug>(blankDown)

" }}}
" comfort binds {{{

" rationale: ( is way more comfortable than {, and I use paragraph jump way more than sentence
nnoremap ( {
xnoremap ( {
nnoremap ) }
xnoremap ) }

" as vim-wordmotion sequestered our `w` binds, we must provide an alternative
" more info here: https://github.com/chaoren/vim-wordmotion/issues/6
xnoremap io iw
xnoremap ao aw
onoremap io iw
onoremap ao aw

omap ir i[
omap ar a[
xmap ir i[
xmap ar a[

omap ic i{
omap ac a{
xmap ic i{
xmap ac a{

" in test: scroll horizontally in wrap off mode
nnoremap z> g$zs
nnoremap z< zeg0
nmap z<RIGHT> z>
nmap z<LEFT> z<

" navigate vim help files
nnoremap  } <C-]>
nnoremap {  <C-T>

" }}}

" }}}
" plugin binds {{{

" easyalign {{{

nmap ga <Plug>(EasyAlign)
xmap <cr> <Plug>(EasyAlign)

" }}}

" }}}

" }}}
" auto commands {{{

" use cursor line only when in current window and out of insert mode
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" foldmethod configurations
autocmd BufRead * setlocal foldmethod=marker
  set foldlevelstart=0

" jump to last cursor
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" specify syntax highlighting for specific files
autocmd Bufread,BufNewFile *.md set filetype=markdown " Vim interprets .md as 'modula2' otherwise, see :set filetype?
autocmd Bufread,BufNewFile *.bowerrc set filetype=json

" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
autocmd Filetype markdown setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 conceallevel=0 fdm=expr
autocmd FileType sh,ruby,yaml,zsh,vim setlocal shiftwidth=2 tabstop=2 expandtab

autocmd FileType java setlocal shiftwidth=4 tabstop=4 expandtab

autocmd Filetype gitcommit setlocal spell textwidth=80

" disabling auto commenting on new line, e.g. 'o' and 'O'
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" enabling <cr> to work properly on the quickfix window
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" quick bind for a 'wrap' command
command! -nargs=* Wrap set wrap linebreak nolist

" machit.vim extends % operator to work on html tags.
runtime macros/matchit.vim

" without this hack, % operator breaks on markdown file match navigation. e.g: '[' and '['.
" I suspect that other filetypes also need this.
autocmd BufReadPre,FileReadPre *.md,*.jsp MatchDebug

" fix for <CR> in command-line-window
silent! autocmd CmdwinEnter * nunmap <cr>
silent! autocmd CmdwinLeave * nnoremap <cr> :w<cr>

" }}}
" highlights {{{

" fix contrast issue with solarized dark.
" https://github.com/airblade/vim-gitgutter/issues/164
highlight clear SignColumn

" }}}
"  functions {{{

" my custom function for opening up new lines without leaving normal mode
" as a bonus, the cursor point is unchanged
" TODO: I sequester the `z` mark. Maybe there's a better way to do this?
function! s:blankUp()
  execute "normal mzO\<esc>`z"
  silent! call repeat#set("\<Plug>(blankUp)", 1)
endfunction
nnoremap <Plug>(blankUp) :<C-u>call <SID>blankUp()<CR>
function! s:blankDown()
  execute "normal mzo\<esc>`z"
  silent! call repeat#set("\<Plug>(blankDown)", 1)
endfunction
nnoremap <Plug>(blankDown) :<C-u>call <SID>blankDown()<CR>

" }}}
" hacks {{{

" sunaku's vim/tmux 256color hack. more info here:
" https://github.com/ninrod/tricks/blob/master/shell/tmux.md#sunakus-hack-for-fixing-256-colors-colorschemes-for-vim-inside-tmux
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" }}}
