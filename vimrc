" My vimrc
" The_Squid


" General {{{
" ====================
" For pathogen to work
execute pathogen#infect()

" To allow \":Man cmd"
runtime! ftplugin/man.vim

set number              " Line numbers
syntax on               " syntax highlighting
set tabstop=4
set shiftwidth=4
set softtabstop=4
set showcmd             " Show commands in the bottom right corner
set hidden
set hlsearch            " Highlight search results
set incsearch           " Searches while still typing
set ai                  " Sets autoindent
set cursorline
set vb                  " Turn off terminal bell
set colorcolumn=80      " Turn on the colored column at column 80
set textwidth=90
set spelllang=en_us
set nowrap              " Turn off line wraps
set t_ut=

set shell=bash\ --login " make the sh command source the bash_profile

"set list
set listchars=tab:▸\ ,eol:¬

let mapleader="-"

" }}}

" Mappings {{{
" ====================
nnoremap <space> zt

" Map colon to semicolon and the reverse
nnoremap ; :
nnoremap : ;

" Delete a function
nnoremap <leader>df vf{%d

" Change the window size more easily
nnoremap <silent> <leader>a <C-w>10<
nnoremap <silent> <leader>d <C-w>10>

" Move across windows holding control
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make with all cores
nnoremap <leader>n :make! -j<cr>

" reload the all files in the arg list
nnoremap <leader>r :argdo e!<cr>

" Use vimgrep to search for the previous search in the arg list
nnoremap <leader>v :vimgrep /<C-r>//g ##<cr>

" SyntasticToggle - following vim unimpaired style
nnoremap coz :SyntasticToggleMode<cr>

" Change Tmux Line color scheme
nnoremap <leader>z :Tmuxline airline_insert<cr>

" See the full file path 
nnoremap <leader>p :echo expand("%:p")<cr>

" Open and close the quickfix list
nnoremap <leader>co :copen<cr>
nnoremap <leader>cc :cclose<cr>

" Change CWD for the window to the dir of the current file
nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

" Eval till = char
nnoremap <leader>= vt="zyf=a <C-r>=<C-r>z<cr><esc>

nnoremap <silent> <leader>i :call Idea()<cr>

" Calling external commands
nnoremap <leader>c :!clear<cr><cr>:echo "Terminal Cleared"<cr>

" Run the current line as a command and read in the output
nnoremap <leader>q !!sh<cr>

" Edit Bash Profile
nnoremap <leader>eb :split ~/.bash_profile<cr>

" Source Bash Profile
nnoremap <leader>sb :!source ~/.bash_profile<cr>

" Edit vimrc 
nnoremap <leader>ev :split ~/.vim/vimrc<cr>

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Edit tmux config
nnoremap <leader>et :split ~/.tmux.conf<cr>

" Source tmux config
nnoremap <leader>st :!tmux source-file ~/.tmux.conf<cr>

" Edit my GTD todo list
nnoremap <leader>g :split ~/Desktop/todo.txt<cr>

" }}}

" Autocommands {{{
" ====================
augroup text
	autocmd!
	autocmd FileType text,unix :setlocal wrap spell foldmethod=indent
augroup END

augroup python
	autocmd!
	autocmd FileType python :setlocal list foldmethod=indent
	autocmd FileType python :nnoremap <buffer> <leader>t :!python <C-r>%<cr>
augroup END

augroup javascript
	autocmd!
	autocmd FileType javascript :iabbrev <buffer> clog console.log()<esc>i<bs>
	autocmd FileType javascript :nnoremap <buffer> <leader>t :!node <C-r>%<cr>
augroup END

augroup sh
	autocmd!
	autocmd FileType sh :nnoremap <buffer> <leader>t :!./%<cr>
augroup END

augroup html
	autocmd!
	autocmd FileType html :setlocal nowrap
augroup END

augroup C
	autocmd!
	autocmd FileType c :setlocal list foldmethod=syntax
	autocmd FileType c :iabbrev <buffer> xmain int main()<cr>{<cr><cr>}<esc>ki	<bs>
augroup END

augroup vim
	autocmd!
	autocmd FileType vim :setlocal foldmethod=marker
augroup END
" }}}

" Color Scheme {{{
" ====================
hi clear
colorscheme badwolf
" colorscheme sky
" colorscheme brogrammer

" }}}

" Abbreviations {{{
" ====================
iabbrev teh the
iabbrev Teh The
iabbrev THe The

iabbrev Im I'm
iabbrev im I'm

iabbrev yuo you
iabbrev Yuo You

iabbrev taht that
iabbrev Taht That

iabbrev waht what
iabbrev Waht What

iabbrev tehn then
iabbrev Tehn Then

iabbrev xdate <c-r>=strftime("%m/%d/%y %H:%M:%S")<cr><esc>@o2jo
iabbrev xbash #!/bin/bash
iabbrev xpython #!/usr/bin/python

" Turn sleep on and off (OSX)
cnoreabbr caf !caffeinate -d&
cnoreabbr kcaf !killall caffeinate

" Todo: use retab instead
cnoreabbr xwhite %s/    /\t/g

cnoreabbr makec make! clean; make -j
cnoreabbr makel make! load_elf -j

cnoreabbr count %s///gn

" }}}

" Functions {{{
" ===================
function! Idea()
	let filename = expand(system("~/bin/idea"))
	echom filename
	execute "edit" filename
endfunction

function! MlTab()
	let &l:tabstop = 2
	let &l:shiftwidth = 2
	let &l:softtabstop = 2
	let &l:expandtab = 1
	exe "retab"
	echo "Tabs Set to 2"
endfunction

function! ArgExp()
	argdo exe "normal! zR"
	syntax on
endfunction

" }}}

" Plugins stuff {{{
" ===================
" Plugin list
" NERDTREE
" Bufferline
" Airline
" Tmuxline
" Syntastic
" Fugitive
" CtrlP

" NERDTree {{{
" ======================
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
" ignore .o files - see :h NERDTreeIgnore
let NERDTreeIgnore=['\.o$[[file]]', '\.py[cdo]$[[file]]']

" Close vim if nerdtree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set winfixwidth

" }}}

" Bufferline
" ======================
let g:bufferline_echo = 0

" Airline {{{
" ======================
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_loaded = 1

set noshowmode   " Gets rid of the original showing of modes in vim
set laststatus=2 " Shows the status bar even if there is only one file

" badwolf
" dark
" durant
" luna
" sky
" wombat
let g:airline_theme= 'dark'

let g:airline#extensions#bufferline#enabled = 1

let g:airline#extensions#branch#enabled = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " splits and tab number
let g:airline#extensions#tabline#show_tabs = 1   " shows tabs regardless of num

let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''

let g:airline#extensions#syntastic#enabled = 1
let g:airline_section_warning = '[syntastic]'
let g:airline#extensions#whitespace#checks = 'long'

" }}}

" Tmux line {{{
" ======================

" crosshair
" full
" minimal
" nightly_fox
" powerline
" righteous
" tmux

" let g:tmuxline_preset = 'powerline'
" let g:tmuxline_preset = {
" 	\'a'       : '#S:#I',
" 	\'b disabled'       : '',
" 	\'c disabled'       : '',
" 	\'win'     : ['#I', '#W'],
" 	\'cwin'    : ['#I', '#W'],
" 	\'x disabled'       : '',
" 	\'y'       : ['%a', '%m-%d-%Y', '%l:%M%p'],
" 	\'z'       : ['#(whoami)', '#h'],
" 	\'options' : {'status-justify': 'left'}}
" 
" }}}

" Syntastic {{{
" ======================
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_mode_map = {'mode': 'active',
	\ 'active_filetypes': [],
	\ 'passive_filetypes': ['html'] }


let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E302,E128,W191'
let g:syntastic_javascript_checkers = ['jshint']
" }}}

" Ctrl P {{{
" ======================

set runtimepath^=~/.vim/bundle/ctrlp.vim
nnoremap <leader>m :CtrlPMRUFiles<cr>
nnoremap <leader>b :CtrlPBuffer<cr>

" }}}

" Fugitive {{{
" ======================

nnoremap $b :Gblame<cr>
nnoremap $c :Gcommit<cr>
nnoremap $d :Gdiff<cr>
nnoremap $s :Gstatus<cr>
nnoremap $w :Gwrite<cr>

" }}} 


" }}}
