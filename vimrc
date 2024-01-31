set rtp+=~/.vim/
set rtp+=~/.vim/plugged/OmniCppComplete
set rtp+=~/.vim/plugged/a.vim-2.18
set rtp+=~/.vim/plugged/nerdtree-7.1.1
set rtp+=~/.vim/plugged/taglist.vim-4.5
set rtp+=~/.vim/plugged/vim-airline-v0.11
set rtp+=~/.vim/plugged/vim-cpp-enhanced-highlight-0.1
set rtp+=~/.vim/plugged/vim-quickhl-v1.0
set rtp+=~/.vim/plugged/molokai
set rtp+=~/.vim/plugged/fzf.vim
set rtp+=~/.vim/plugged/fzf

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

    augroup END

else
    set autoindent        " always set autoindenting on
endif " has("autocmd")

set t_Co=256
set ts=4
set nocompatible

set backspace=indent,eol,start

set history=50      " keep 50 lines of command line history
set showcmd         " display incomplete commands
set incsearch       " do incremental searching

colorscheme molokai
syntax on
set hlsearch
set expandtab tabstop=4 shiftwidth=4 "foldmethod=syntax
set shiftwidth=4
set autoindent      " always set autoindenting on
set number
set nofen
set noic " set ic to ignore case
set tags=tags;,tags
set tags+=~/.vim/systags


"set foldmethod=indent
"set foldmethod=syntax

"set fileencodings=utf-8,gb2312,gbk,gb18030
"set fileencodings=gb2312,gbk,gb18030
"set fileencodings=gbk
set fileformats=unix
"set termencoding=utf-8
"set termencoding=gbk
"set encoding=prc
"set encoding=gbk
"set encoding=gb18030

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set nocp
filetype plugin on
set tabstop=4
set softtabstop=4
set shiftwidth=4

set completeopt=menu,longest
inoremap <C-l> <Right>
nnoremap <space>w :w!<CR>
nnoremap tn :tn<CR>
nnoremap tp :tp<CR>
nnoremap ma mA
nnoremap ms mS
nnoremap md mD
nnoremap 'a 'A
nnoremap 's 'S
nnoremap 'd 'D

set showcmd                     " display incomplete commands
set ruler                       " show the cursor position all the time
set wildignore=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions
set wildmenu                    " command-line completion in an enhanced mode

function! UpdateCtags()
    let curdir=getcwd()
    while !filereadable("./tags")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./tags")
        silent !ctags -R --file-scope=yes --langmap=c:+.h --langmap=c++:+.inl --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q $PWD > /dev/null 2>&1 &
    endif
    execute ":cd " . curdir
endfunction

function! SyncCscope()
    let curdir=getcwd()
    while !filereadable("./cscope.out")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./cscope.out")
        silent !cscope -Rbq
    endif
    execute ":cd " . curdir
    exec "cs reset"
endfunction
"nmap <F10> :call UpdateCtags()<CR>
set scrolloff=8
set cursorline
set cscopetag

inoremap <C-c> <ESC>

inoremap  ,  ,<Space>
"-------------------------------------------------------------------------------
" autocomplete parenthesis, brackets and braces
"-------------------------------------------------------------------------------
"inoremap ( ()<Left>
"inoremap [ []<Left>
"inoremap { {}<Left>
set cscopequickfix=s-,c-,d-,i-,t-,e-
"
vnoremap ( s()<Esc>P<Right>%
vnoremap [ s[]<Esc>P<Right>%
vnoremap { s{}<Esc>P<Right>%
"
"-------------------------------------------------------------------------------
" autocomplete quotes (visual and select mode)
"-------------------------------------------------------------------------------
xnoremap  '  s''<Esc>P<Right>
xnoremap  "  s""<Esc>P<Right>
xnoremap  `  s``<Esc>P<Right>
"
"-------------------------------------------------------------------------------
 noremap <silent> <Space>l  <Esc><Esc>:Tlist<CR>
 noremap <Space>e :q<CR>
 noremap <Space>q :qa<CR>
 noremap <Space>w :w!<CR>

let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select 				= 1

let tlist_make_settings  = 'make;m:makros;t:targets'
let tlist_qmake_settings = 'qmake;t:SystemVariables'

nnoremap gw :grep -r -w <cword> * --exclude=tags --exclude=*.o<CR>
nnoremap gr :grep -r -e '\-><cword>' -e '\.<cword>' * --exclude=tags --exclude=*.o<CR>
au BufWritePost *.c,*.cpp,*.h call UpdateCtags()
nnoremap zj zfi{
nnoremap zk zf%
vnoremap gw y:grep -r -E '<C-R>0' * --exclude=tags --exclude=*.o<CR>

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

nnoremap <leader>tt :Tags <CR>
command! MakeTags !ctags -R --c++-kinds=+px  --langmap=c++:+.inl --fields=+afmikKlnsStz --extra=+q $PWD
command! SyncCsope call SyncCscope()
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <SPACE>v :NERDTreeFind<CR>
nnoremap ;h :copen<CR>
nnoremap ;l :cclose<CR>
nnoremap ;j :cn<CR>
nnoremap ;k :cp<CR>

nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

