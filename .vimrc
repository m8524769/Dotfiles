runtime! debian.vim
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/gvimrc_example.vim
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
source $VIMRUNTIME/mswin.vim
behave mswin

let $USERNAME='yk'
let mapleader=","
let g:mapleader = ","

let $VIMRC='~/.vimrc'
nmap <leader>v :vi $VIMRC<CR>

" 基本界面配置
set laststatus=2
set t_Co=256
colorscheme molokai2
set guifont+=InconsolataGo\ QiHei\ NF\ 17
set guifont+=DejaVuSansMono\ YaHei\ NF\ 15
set guifont+=FiraCode\ QiHei\ NF\ 14
" set guifont+=InconsolataGo\ QiHei\ NF:h17
" set guifont+=DejaVuSansMono\ YaHei\ NF:h15
" set guifont+=FiraCode\ QiHei\ NF:h14
set number
set relativenumber
set nowrap
set cursorcolumn
set cursorline
set cmdheight=1
set go=

" 缩进配置
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set cindent
set cino=g0
filetype on
filetype indent on
nnoremap <CR> ==<CR>

" 编码配置
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,Shift_JIS,cp936,gb18030,big5,euc-jp,latin1
set langmenu=zh_CN.utf-8
set helplang=CN
let $LANG = 'en_US.utf-8'
language messages zh_CN.utf-8

" 取消备份及交换文件
set nobackup
set noswapfile
set noundofile

" 禁用<F1>
map  <F1> <Esc>
imap <F1> <Esc>

" 禁用蜂鸣警告
set vb t_vb=

" 切换窗口
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" 光标移动增强
nmap H ^
vmap H ^
omap H ^
nmap L $
vmap L $
omap L $

" 插入模式快捷键
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap <C-u> <Esc> u
imap jk <Esc>

" Operator-Pending映射
onoremap in( :<c-u>normal! f(vi(<CR>
onoremap in[ :<c-u>normal! f[vi[<CR>
onoremap in{ :<c-u>normal! f{vi{<CR>
onoremap in< :<c-u>normal! f<vi<<CR>
onoremap in" :<c-u>normal! f"vi"<CR>
onoremap in' :<c-u>normal! f'vi'<CR>

" 代码折叠
set foldenable
set foldmethod=syntax
set foldcolumn=0
set foldlevelstart=99

" 共享系统剪切板
set clipboard=unnamedplus
" set clipboard=unnamed

" 集成终端
set shell=/bin/zsh

" 自动载入
set autoread
set history=200

" 默认工作目录
let $PWD = $HOME . "/Projects"
if isdirectory($PWD)
    cd $PWD
endif

" C/C++代码片段 <C-CR>
imap <C-CR> +<Space><BS>
iabbrev pf+ printf;<Left>("
iabbrev sf+ scanf;<Left>("
iabbrev cout+ cout <<  << endl;<Esc>==8li
iabbrev cin+ cin >> ;<Esc>==$i
iabbrev do+ do {}while ();<Esc>==f}i<CR><Esc>f)i
iabbrev switch+ switch ()<CR>
                \{}<Left><CR>
                \case '': <CR>
                \case '': <CR>
                \default: <CR>
                \<Esc>5k6==$i
iabbrev struct+ struct {};<Left><Left><CR><Esc>k2==wi
iabbrev class+ class CLASSNAME {};<Left><Left><CR>
                \public:<CR>
                \CLASSNAME() {}<CR>
                \CLASSNAME(CLASSNAME const &) {}<CR>
                \virtual ~CLASSNAME() = default;<CR>
                \private:<CR>
                \<Esc>6k7==
                \:.,.+4s/CLASSNAME//g<Left><Left>
iabbrev try+ try {}<Left><CR>
                \<Right> catch () {}<Left><CR>
                \<Right> catch () {}<Left><CR>
                \<Esc>3k4==o

" 代码初始化模板
iabbrev cmain+ /* <c-r>=strftime("New at %m/%d 20%y " . $USERNAME)<CR> */<CR>
                \#include <stdio.h><CR><CR>
                \int main()<CR>
                \{}<Left><CR><CR><CR><Up><Tab>
                \return 0;<Up><Up>
iabbrev cppmain+ /* <c-r>=strftime("New at %m/%d 20%y " . $USERNAME)<CR> */<CR>
                \#include <bits/stdc++.h><CR><CR>
                \using namespace std;<CR>
                \std::ifstream tcin("./stdin.txt");<CR><CR>
                \int main()<CR>
                \{}<Left><CR><CR><Up><Tab>
                \freopen("./stdin.txt", "r", stdin);<CR><CR><CR>
                \cout << "Runtime: " << clock()*1000/CLOCKS_PER_SEC << "ms";<CR>
                \return 0;<Up><Up><Up>
iabbrev shmain+ #!/bin/bash<CR><CR>
iabbrev pymain+ #_*_ coding: utf-8 _*_<CR>
                \#!/usr/bin/env python3<CR><CR>
iabbrev rbmain+ #!/usr/bin/env ruby<CR><CR>
iabbrev guard+ #ifndef <c-r>=expand("%")<CR><CR>
                \#define <c-r>=expand("%")<CR><CR>
                \#endif // <c-r>=expand("%")<CR>
                \<ESC>2k
                \:.,.+2s/\v(\w+)\.h/_\U\1_H_/g<CR>O

augroup code_template
    autocmd!
    autocmd BufNewFile *.c   :normal icmain+
    autocmd BufNewFile *.cpp :normal icppmain+
    autocmd BufNewFile *.h   :normal iguard+
    autocmd BufNewFile *.sh  :normal ishmain+
    autocmd BufNewFile *.py  :normal ipymain+
    autocmd BufNewFile *.rb  :normal irbmain+
augroup END

" 括号自动补全
inoremap ( ()<Esc>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap [ []<Esc>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap { {}<Esc>i
inoremap } <c-r>=ClosePair('}')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

function! QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "\\"
        return a:char
    elseif line[col - 1] == a:char
        return "\<Right>"
    else
        return a:char.a:char."\<Esc>i"
    endif
endfunction


" Vim-plug 插件列表
filetype off
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 ./install.py --clang-completer' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'skywind3000/asyncrun.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'terryma/vim-multiple-cursors'
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'
Plug 'mhinz/vim-startify'
Plug 'iamcco/dict.vim'
Plug 'm8524769/Baidu.vim'
Plug 'terryma/vim-smooth-scroll'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'neovimhaskell/haskell-vim'
Plug 'm8524769/leetcode.vim'
call plug#end()



" EasyMotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_startofline = 0
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_move_highlight = 0
map  / <Plug>(easymotion-sn)
nmap ; <Plug>(easymotion-next)


" 垂直分屏 <F3>
map <silent> <F3> :call VerticalSplit()<CR>
imap <silent> <F3> <Esc> :call VerticalSplit()<CR>
let g:is_vsplit = 0
function! VerticalSplit()
    if g:is_vsplit
        execute "only"
        let g:is_vsplit = 0
    else
        execute "vsplit"
        let g:is_vsplit = 1
    endif
endfunction


" 平滑滚屏
noremap <silent> J :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> K :call smooth_scroll#up(&scroll, 0, 2)<CR>
" C++ 语法高亮增强
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
" Devicons
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
let g:WebDevIconsUnicodeGlyphDoubleWidth = 2
" IndentLine
let g:indentLine_char = "\u250A"
let g:indentLine_concealcursor = ''
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']
" multiple-cursors 多行编辑 <C-(n|p|x)>
set selection=inclusive
let g:multi_cursor_use_default_mapping=1
let g:multi_cursor_quit_key='<CR>'
" Ctags 代码索引
set autochdir
set tags+=$VIM/vimfiles/systags
set tags+=./tags
" Vim-Surround
vmap s gS
" LeetCode
let g:leetcode_username = 'm8524769'
let g:leetcode_password = ''
let g:leetcode_language = 'zh_CN'


" NERD_Tree 资源管理器 <F5>
map <silent> <F5> :NERDTreeToggle<CR>
imap <silent> <F5> <Esc> :NERDTreeToggle<CR>
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\.o$', '\.pyc$', '\~$', '\.gif', '\.jpg', '\.png']
let g:NERDTreeMouseMode = 3
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeDirArrowExpandable = "\uE5FF"
let g:NERDTreeDirArrowCollapsible = "\uE5FE"
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" Nerd_Commenter 注释增强 <Leader>c<Space>
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 0
let g:NERDTrimTrailingWhitespace = 1


" TagBar 函数列表 <F6>
map <silent> <F6> :TagbarToggle<CR>
imap <silent> <F6> <Esc> :TagbarToggle<CR>
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 30
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
let g:tagbar_autopreview = 1
let g:tagbar_autoshowtag = 1


" QuickFix 信息窗口 <F2>
map <silent> <F2> :call QuickfixToggle()<CR>
imap <silent> <F2> <Esc>:call QuickfixToggle()<CR>
let g:quickfix_is_open = 0
let g:quickfix_return_to_window = winnr()
function! QuickfixToggle()
    if g:quickfix_is_open
        execute g:quickfix_return_to_window . "wincmd w"
        execute "cclose"
        let g:quickfix_is_open = 0
    else
        let g:quickfix_return_to_window = winnr()
        execute "copen 8 | setl wrap"
        let g:quickfix_is_open = 1
    endif
endfunction


" AirLine 标签及状态栏 <C-t> <Tab> <Leader>[1-9]
nmap <silent> <C-t> :tabnew<CR>
imap <silent> <C-t> <Esc> :tabnew<CR>
let g:airline_theme="onedark"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#alt_sep = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
" let g:airline#extensions#tabline#buffers_label = 'Buffers'
" let g:airline#extensions#tabline#tabs_label = 'Tabs'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <Tab>     <Plug>AirlineSelectNextTab
nmap <S-Tab>   <Plug>AirlineSelectPrevTab
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
let g:airline#extensions#tabline#keymap_ignored_filetypes = ['vimfiler', 'nerdtree']
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#show_close_button = 0
" let g:airline#extensions#tabline#close_symbol = 'X'
let g:airline#parts#ffenc#skip_expected_string = 'utf-8'
let g:airline#extensions#ale#error_symbol = ' ' " \uF057
let g:airline#extensions#ale#warning_symbol = ' ' " \uF06A
let g:airline#extensions#whitespace#checks = []
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = ''
" let g:airline_left_sep = '' " \uE0B8
" let g:airline_left_alt_sep = '' " \uE0B9
let g:airline_right_sep = '' " \uE0BA
let g:airline_right_alt_sep = '' " \uE0BB
let g:airline_symbols.branch = '⎇ ' " \u2387
let g:airline_symbols.notexists = '' " \uE710
" let g:airline_symbols.crypt = '' " \uE0A2
" let g:airline_symbols.linenr = '☰' " \u2630
" let g:airline_symbols.whitespace = '' " \uF120


" Startify 欢迎界面
let g:startify_padding_left = 4
let g:startify_disable_at_vimenter = 0
let g:startify_bookmarks = [
            \ '~/.vimrc',
            \ '~/.zshrc',
            \ '~/.xinitrc',
            \ '~/.Xresources',
            \ '~/.conkyrc',
            \ '~/.config/fontconfig/fonts.conf',
            \ '~/.config/i3/config',
            \ '~/.config/i3/i3lock.sh',
            \ '~/.config/polybar/config',
            \ '~/.config/polybar/launch.sh',
            \ '~/.config/dunst/dunstrc',
            \ '~/Projects/Script/Clean.sh',
            \ ]
let g:startify_custom_header =
            \ "startify#fortune#cowsay('','═','║','╔','╗','╝','╚')"
let g:startify_list_order = [
            \ ['   Recently Used'],
            \ 'files',
            \ ['   My Bookmarks:'],
            \ 'bookmarks',
            \ ]
let g:startify_custom_footer =
            \ ['', "   Happy Viming!!"]
augroup startify
    autocmd!
    autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)
    autocmd User Startified setlocal cursorline
    autocmd VimEnter * let t:startify_new_tab = 1
    autocmd BufEnter *
                \ if !exists('t:startify_new_tab') && empty(expand('%')) |
                \   let t:startify_new_tab = 1 |
                \   Startify |
                \ endif
augroup END


" YouCompleteMe 代码补全
let g:ycm_confirm_extra_conf = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1


" ALE 异步代码检测及修复
nmap <silent> N <Plug>(ale_next_wrap)
nmap <silent> P <Plug>(ale_previous_wrap)
nmap <silent> <F8> <Plug>(ale_fix)
" let g:ale_enabled = 1
" let g:ale_sign_column_always = 0
let g:ale_sign_error = " \uF12A"
let g:ale_sign_warning = " \uF128"
let g:ale_echo_msg_format = '%s'
let g:ale_history_enabled = 0
let g:ale_set_quickfix = 1
let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_on_text_changed = 'always'
let g:ale_linters = {
            \'c': ['clang'],
            \'cpp': ['clangtidy'],
            \'Bash': ['shellcheck'],
            \'Python': ['flake8'],
            \'Vim': ['vint'],
            \}
let g:ale_linters_explicit = 1
let g:ale_fixers = {
            \'cpp': [
            \   'remove_trailing_lines',
            \   'CPP_ALEFix'
            \   ]
            \}
let g:ale_cpp_clang_options = '-std=c++17'
let g:ale_cpp_clangtidy_options = '-std=c++17'
let g:ale_cpp_clangtidy_checks = ['-*, clang-analyzer-*, hicpp-*, modernize-*, performance-*']
let g:ale_python_flake8_executable = 'python'
let g:ale_python_flake8_args = '-m flake8'
if !hlexists('ALEErrorSign')
    highlight link ALEErrorSign todo
endif
function! CPP_ALEFix(...)
    silent execute "w"
    silent execute "!clang-tidy -fix-errors % --"
    echo "代码已修复 _(:3」∠)_"
endfunction


" 有道翻译 <Leader>(d|t) 命令行/窗口
let g:api_key = "1932136763"
let g:keyfrom = "aioiyuuko"
nmap <silent> <Leader>d <Plug>DictSearch
vmap <silent> <Leader>d <Plug>DictVSearch
nmap <silent> <Leader>t <Plug>DictWSearch
vmap <silent> <Leader>t <Plug>DictWVSearch
nmap <silent> <Leader>r <Plug>DictRSearch
vmap <silent> <Leader>r <Plug>DictRVSearch


" :Test命令 在当前目录下创建测试输入文件 <F4>
map <F4> :Test<CR>
imap <F4> <Esc> :Test<CR>
if !exists(':Test')
    command! -nargs=0 Test 25vsplit stdin.txt
endif
if !exists(':CleanTest')
    command! -nargs=0 CleanTest call CleanTest()
endif
function! CleanTest()
    silent! %s/tcin >>/cin >>/g
    silent g/stdin.txt/d
    silent execute "w"
endfunction


" 编译及执行命令
augroup compile_command
    autocmd!
    autocmd FileType c       call C_Command()
    autocmd FileType cpp,cxx call CPP_Command()
    autocmd FileType sh      let b:RunCommand = "!bash %"
    autocmd FileType python  let b:RunCommand = "!python3 %"
    autocmd FileType ruby    let b:RunCommand = "!ruby %"
    autocmd FileType haskell let b:RunCommand = "term ghci %"
    autocmd FileType javascript let b:RunCommand = "!node %"
    autocmd FileType typescript let b:RunCommand = "!ts-node %"
augroup END

function! C_Command() " Use LLVM/Clang Compiler
    let b:CompileCommand = "AsyncRun clang -std=c99 -Wall -O1 -c %"
    let b:LinkCommand    = "!clang ./*.o -o Run"
    let b:RunCommand     = "!./Run"
    map <C-F7> :AsyncRun clang -std=c99 -Wall -g -O1 -c %
    map <C-F9> :!clang ./*.o -o Run && time ./Run
endfunction

" function! CPP_Command() " Use GCC Compiler
"     let b:CompileCommand = "AsyncRun g++ -std=c++17 -Wall -O1 -c %"
"     let b:LinkCommand    = "!g++ ./*.o -o Run"
"     let b:RunCommand     = "!./Run"
"     map <C-F7> :AsyncRun g++ -std=c++17 -Wall -g -O1 -c %
"     map <C-F9> :!g++ ./*.o -o Run && time ./Run
" endfunction

function! CPP_Command() " Use LLVM/Clang Compiler
    let b:CompileCommand = "AsyncRun clang++ -std=c++1z -stdlib=libc++ -Wall -Weffc++ -O0 -c %"
    let b:LinkCommand    = "!clang++ -lc++ -lc++abi ./*.o -o Run"
    let b:RunCommand     = '!./Run'
    map <C-F7> :AsyncRun clang++ -std=c++1z -stdlib=libc++ -Weverything -g -O2 -c %
    map <C-F9> :!clang++ -lc++ -lc++abi ./*.o -o Run && ./Run
endfunction


" AsyncRun(异步编译) <F7> <C-F7>
" 保存并编译生成目标文件
map <silent> <F7> :call AsyncCompile()<CR>
imap <F7> <Esc> <F7>
function! AsyncCompile()
    if exists('b:CompileCommand')
        silent execute "w"
        execute b:CompileCommand
        if g:ale#engine#GetLoclist(buffer_number("%")) == []
            echo "Compiled Successfully!! o(*≧▽≦)ツ"
        else
            execute "TagbarClose"
            let g:quickfix_return_to_window = winnr()
            execute "copen 8 | setl wrap"
            let g:quickfix_is_open = 1
            execute g:quickfix_return_to_window . "wincmd w"
        endif
    else
        echo "当前文件并不能编译.. ╮(￣▽￣)╭"
    endif
endfunction


" Link & Run <F9> <C-F9>
" 链接当前目录的所有目标文件, 生成可执行文件并运行
map <silent> <F9> :call Link_Run()<CR>
imap <F9> <Esc> <F9>
function! Link_Run()
    if g:quickfix_is_open
        execute g:quickfix_return_to_window . "wincmd w"
        execute "cclose"
        let g:quickfix_is_open = 0
    endif
    if exists('b:LinkCommand')
        execute b:LinkCommand
    endif
    if exists('b:RunCommand')
        execute b:RunCommand
        echohl WarningMsg | echo "Running Finish! o(*≧▽≦)ツ"
    else
        echo "不是可执行文件.."
    endif
endfunction


" 清除当前目录的所有目标文件及可执行文件 <F10>
map <silent> <F10> :call CleanObjFile()<CR>
imap <F10> <Esc> <F10>
function! CleanObjFile()
    silent execute "!rm ./*.o ./Run"
    echohl WarningMsg | echo "Cleaning Successfully! (ﾉ･ω･)ﾉﾞ"
endfunction

if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

