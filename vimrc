" The One Vimrc
" Type zR to open all folds, zM to close all folds
" za will toggle a single fold

" Core Vimrc {{{
" load indentation and syntax rules according to the detected filetype.
syntax on
filetype plugin indent on
colorscheme molokai

set cmdheight=2          " Make cmd window 2 lines high
set showmatch            " Show matching brackets.
set ignorecase           " Do case insensitive matching...
set smartcase            " Unless the string includes upcase letters
set incsearch            " Start highlighting search results as you type
set autowrite            " Automatically save before commands like :next and :make
set hidden               " Hide buffers when they are abandoned
set mouse=a              " Enable mouse usage (all modes)
set number               " Display line numbers
set nocompatible         " Disable legacy Vi compatibility
set tabstop=2            " Ruby style 2-space indentation
set softtabstop=2        " Ruby style 2-space indentation
set shiftwidth=2         " Ruby style 2-space indentation
set expandtab            " Expands tabs to spaces
set hlsearch             " Highlight search terms (use :noh to deactivate)
set nobackup             " Don't leave a backup file
set smarttab             " Smart indenting options
set nospell              " Spell checking is off by default
set foldmethod=marker    " Use markers for folding
set wildmenu             " Better command-line completion
set nomodeline           " Disables Modelines for Security Reasons
set showcmd              " Show (partial) command in status line.
set backspace=2          " Works like the normal backspace
set visualbell           " Use visual bell instead of beeping
set confirm              " Ask to save if running a cmd on unsaved buffer
set cc=81                " Sets a visual mark for lines longer than 80 char

execute pathogen#infect()

"}}}
" GUI Options"{{{
if has("gui_running")
  " See ~/.gvimrc
  set guifont=Monaco:h13
  set lines=120
  set columns=90
  set background=light
  colorscheme solarized
  set cursorline cursorcolumn
endif
"}}}
" Mappings and Shortcuts {{{

" Setting the statusline
set laststatus=2
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%{GitBranch()}%h%m%r%y%=%c,%l/%L\ %P

" Function to display git branch
function! GitBranch()
  let branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
  if branch != ''
    return '[Git Branch: ' . substitute(branch, '\n', '', 'g') . ']'
  en
  return ''
endfunction

" Highlight all tabs
"highlight AnyTabs ctermbg=darkred guibg=#382424
"autocmd ColorScheme * highlight AnyTabs ctermbg=red guibg=red
"autocmd BufWinEnter * match AnyTabs /\t/

" Run Commands
command Runclj w |!lein run %
command Runex w |!elixir %
command Cake w |!cake run %
command Runrb w |!ruby %
command Rungo w |!go run %
command Runhs w |!runhaskell %
command Runrs w |!rustc % && ./%:r
command Runc w |!gcc -std=c99 % && time ./a.out
command Runpy w |!python %
command Testrs w |!rustc --test % && ./%:r
command Strail %s/\s*$//g

" Setting the F keys to run different files
nnoremap <F4> :Runclj <CR>
nnoremap <F5> :Runrb <CR>
nnoremap <F6> :Rungo <CR>
nnoremap <F7> :Runpy <CR>

" Other commands
command WC w |!wc %

" Set a key shortcut for folding when using mt and mb to mark the top and
" bottom of the fold (<C-z> previously was 1/2 page up)
nmap <C-z> :'t,'bfo <CR>

" Map Y so that it works like D and C instead of yy, D and C perform their
" respective operations to the EOL rather than the whole line.
map Y y$

" Map <C-l> to first turn off search highlighting with :nohl, and then execute
" its current function, which is to redraw the screen.
nnoremap <C-l> :nohl<CR><C-l>

" EZCMD: Maps : to ; in normal mode for easier entering of commands
" then remaps the ; to being a double press of the ; key. More details
" in the Readme section under EZCMD
nmap ; :
noremap ;; ;

" Toggle NERDTree
noremap tt :NERDTreeToggle<CR>

" Change statusline based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=bold
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif

" Mapping j and k keys to move within wrapped lines
map j gj
map k gk

"}}}
" Misc and Random"{{{

" Show syntax highlighting groups for word under cursor
" This is for designing colorschemes, when pressed it displays which code
" coloring categories that item belongs to, great for tracking down weird,
" language specific traits when designing a scheme
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
"}}}
" File Specific Commands"{{{

autocmd BufRead *\.txt setlocal wrap
autocmd BufRead *\.txt setlocal linebreak
autocmd BufRead *\.txt setlocal nolist
autocmd BufRead *\.txt setlocal textwidth=0
autocmd BufRead *\.txt setlocal wrapmargin=0
autocmd BufRead *\.txt setlocal smartindent
autocmd BufRead *\.txt setlocal spell spelllang=en_us

autocmd BufRead *\.markdown setlocal wrap
autocmd BufRead *\.markdown setlocal linebreak
autocmd BufRead *\.markdown setlocal nolist
autocmd BufRead *\.markdown setlocal textwidth=0
autocmd BufRead *\.markdown setlocal wrapmargin=0
autocmd BufRead *\.markdown setlocal smartindent
autocmd BufRead *\.markdown setlocal spell spelllang=en_us

autocmd BufRead *\.md setlocal wrap
autocmd BufRead *\.md setlocal linebreak
autocmd BufRead *\.md setlocal nolist
autocmd BufRead *\.md setlocal textwidth=0
autocmd BufRead *\.md setlocal wrapmargin=0
autocmd BufRead *\.md setlocal smartindent
autocmd BufRead *\.md setlocal spell spelllang=en_us

autocmd FileType *\.py setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType *\.c setlocal shiftwidth=4 tabstop=4 expandtab
" }}}
" Abbreviations and Mappings"{{{
" To avoid unwanted abbreviations:
" :una <abbrev> - will remove abbrev from the list for that session
" :abc - clears all abbreviations
" ctrl-v when typing the last character of the ab will prevent expansion

" Ruby hash rocket
:imap <C-l> =>

" Top-Bottom Fns: use mt to set the top of a block and mb to set the bottom

" ctrl-y yanks the block bounded by the top and bottom marks into register a
nnoremap <C-y> :'t,'by a<CR>

" ctrl-k used to kill the block bounded by top-bottom, now it simply brings up
" the command menu to prevent accidents, it can also now be used to run any
" other command on the range
nnoremap <C-k> :'t,'b

" Spelling Autocorrect
ab shoudl should
ab resposne response
ab woudl would
ab hmtl html
ab liek like
ab wrods words
ab thigns things
ab adn and
ab teh the
ab isnt' isn't
ab taht that
ab liens lines
ab controler controller
ab goign going
ab tobe to be
ab descrieb describe
ab itneresting interesting
ab btu but
"}}}
