runtime! debian.vim                         " 载入默认配置
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/gvimrc_example.vim
source $VIMRUNTIME/delmenu.vim              " 解决菜单乱码
source $VIMRUNTIME/menu.vim
source $VIMRUNTIME/mswin.vim                " 模仿Windows快捷键
behave mswin

let mapleader=","                           " 默认<Leader>键
let g:mapleader = ","

let $MYVIMRC='~/Projects/My_Code/.vimrc'    " <Leader>v 打开.vimrc
nmap <leader>v :vi $MYVIMRC<CR>

"界面配置
set laststatus=2
set t_Co=256
colorscheme molokai2
" colorscheme desert
" colorscheme monokai
" colorscheme wombat
if (!has("gui_running"))
    colorscheme lucius
endif
set guifont=DejaVuSansMonoforPowerline\ Nerd\ Font\ 14
set guifontwide=Microsoft\ YaHei\ Regular\ 14
set number
set relativenumber
set nowrap
set cursorcolumn
set cursorline
set cmdheight=1
set go=

"缩进配置
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

"编码配置
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,Shift_JIS,cp936,gb18030,big5,euc-jp,latin1
set langmenu=zh_CN.utf-8
set helplang=CN
let $LANG = 'en_US.utf-8' 
language messages zh_CN.utf-8

"取消备份及交换文件
set nobackup
set noswapfile
set noundofile
"set backup
"set backupext=.bak
"set backupdir=/tmp/vim_backup/

"禁用<F1>
nmap <F1> <Esc>

"方向键切换窗口
nmap <Left> <C-w>h
nmap <Down> <C-w>j
nmap <up> <C-w>k
nmap <right> <C-w>l

"增强光标移动
nmap H ^
omap H ^
nmap L $
omap L $

"拼接行
nnoremap <C-j> J

"插入模式快捷键映射
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap <C-u> <Esc> u
imap jk <Esc>
imap JK <Esc>

"Operator-Pending映射
onoremap in( :<c-u>normal! f(vi(<CR>
onoremap in[ :<c-u>normal! f[vi[<CR>
onoremap in{ :<c-u>normal! f{vi{<CR>
onoremap in< :<c-u>normal! f<vi<<CR>
onoremap in" :<c-u>normal! f"vi"<CR>
onoremap in' :<c-u>normal! f'vi'<CR>

"代码折叠
set foldenable
set foldmethod=syntax
set foldcolumn=0
set foldlevelstart=99

"与Linux共享剪切
set clipboard=unnamedplus

"自动载入
set autoread
set history=200

"默认操作路径
cd ~/Projects

"C/C++缩写词及代码片段补全 <C-CR>
imap <C-CR> +<Space><BS>
iabbrev ui+ unsigned int <Esc>==$a
iabbrev uc+ unsigned char <Esc>==$a
iabbrev pf+ printf("");<Esc>==f"a
iabbrev sf+ scanf("", &);<Esc>==f"a
iabbrev cout+ cout <<  << endl;<Esc>==f<2la
iabbrev cin+ cin >> ;<Esc>==$i
iabbrev for+ for (; ; )<CR>
            \{}<Left><CR>
            \<Esc>2k3==wa
iabbrev do+ do {}while ();<Esc>==f{a<CR><Esc>f(a
iabbrev switch+ switch ()<CR>
                \{}<Left><CR>
                \case '': <CR>
                \case '': <CR>
                \default: <CR>
                \<Esc>5k6==wa
iabbrev struct+ struct {};<Left><Left><CR><Esc>k2==wi
iabbrev union+ union {};<Left><Left><CR><Esc>k2==wi
iabbrev enum+ enum {};<Left><Left><CR><Esc>k2==wi
iabbrev class+ class CLASSNAME {};<Left><Left><CR>
                \public:<CR>
                \CLASSNAME() {}<CR>
                \~CLASSNAME() {}<CR>
                \private:<CR>
                \<Esc>5k6==
                \:.,.+3s/CLASSNAME//g<Left><Left>
iabbrev try+ try {}<Left><CR>
                \<Right> catch () {}<Left><CR>
                \<Right> catch () {}<Left><CR>
                \<Esc>3k4==o
iabbrev #+ #include <><Left>
iabbrev using+ using namespace <Esc>==$a
iabbrev guard+ #ifndef <c-r>=expand("%")<CR><CR>
                \#define <c-r>=expand("%")<CR><CR>
                \#endif // <c-r>=expand("%")<CR>
                \<ESC>2k
                \:.,.+2s/\v(\w+)\.h/_\U\1_H_/g<CR>O
iabbrev cmain+ /* <c-r>=strftime("New at 20%y.%m.%d(%A) by yk")<CR> */<CR>
                \#include <stdio.h><CR><CR>
                \int main()<CR>
                \{}<Left><CR><CR><CR><CR><Up><Tab>
                \return 0;<Up><Up><Tab>
iabbrev cppmain+ /* <c-r>=strftime("New at 20%y.%m.%d(%A) by yk")<CR> */<CR>
                \#include <iostream><CR>
                \#include <fstream><CR>
                \#include <algorithm><CR>
                \#include <vector><CR><CR>
                \using namespace std;<CR>
                \std::ifstream tcin("./inTest.txt");<CR>
                \std::ofstream tcout("./outTest.txt");<CR><CR>
                \int main()<CR>
                \{}<Left><CR><CR><CR><CR><Up><Tab>
                \return 0;<Up><Up><Tab>

"常用脚本缩写词
iabbrev shmain+ #!/bin/bash<CR><CR>
iabbrev pymain+ #_*_ coding: utf-8 _*_<CR>
                \#!/usr/bin/env python<CR><CR>

"自动插入代码模板及头文件保护符
autocmd BufNewFile *.c   execute "normal icmain+\<Space>"
autocmd BufNewFile *.cpp execute "normal icppmain+\<Space>"
autocmd BufNewFile *.h   execute "normal iguard+\<Space>"
autocmd BufNewFile *.sh  execute "normal ishmain+\<Space>"
autocmd BufNewFile *.py  execute "normal ipymain+\<Space>"

"括号自动补全
inoremap ( ()<Esc>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap [ []<Esc>i
inoremap ] <c-r>=ClosePair(']')<CR>
" inoremap { {}<Esc>i
" inoremap } <c-r>=ClosePair('}')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

function QuoteDelim(char)
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


"Vim-Plug配置及Vim插件列表
filetype off
call plug#begin('$VIM/vimfiles/bundle')
Plug 'junegunn/vim-plug'
Plug 'Shougo/unite.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'universal-ctags/ctags'
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'vim-scripts/a.vim'
Plug 'lambdalisue/vim-fullscreen'
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
call plug#end()
filetype plugin indent on



"EasyMotion (快速跳转)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 1
let g:EasyMotion_startofline = 0
map <Leader> <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)


"平滑滚屏
noremap <silent> J :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> K :call smooth_scroll#up(&scroll, 0, 2)<CR>


"multiple-cursors(多行编辑) <C-(n|p|x)>
set selection=inclusive
let g:multi_cursor_use_default_mapping=1
let g:multi_cursor_quit_key='<CR>'


"垂直分屏 <F3>
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


"C++ 语法高亮
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1


"Devicons
if (!has("gui_running"))
    let g:webdevicons_enable = 0
endif
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''


"Unite
nnoremap <leader>f :<C-u>Unite -start-insert file_rec<CR>


"NERD_Tree (目录树) <F5>
map <silent> <F5> :NERDTreeToggle<CR>
imap <silent> <F5> <Esc> :NERDTreeToggle<CR>
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\.o$', '\.pyc$', '\~$', '\.gif', '\.jpg', '\.png']
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"Nerd_Commenter (多行注释) <Leader>cc <Leader>c<Space>
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 0
let g:NERDTrimTrailingWhitespace = 1


"Ctags (tags代码索引)
set autochdir
set tags+=$VIM/vimfiles/systags
set tags+=./tags


"TagBar (函数列表) <F6>
map <silent> <F6> :TagbarToggle<CR>
imap <silent> <F6> <Esc> :TagbarToggle<CR>
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 30
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
let g:tagbar_autopreview = 1
let g:tagbar_autoshowtag = 1


"QuickFix (编译信息窗口) <F2>
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
        execute "copen 8"
        let g:quickfix_is_open = 1
    endif
endfunction


"AirLine (状态栏及缓冲区标签) <C-Tab> <Leader>[1-9]
map <silent> <C-tab> :bn<CR>
imap <silent> <C-tab> <Esc> :bn<CR>
let g:airline_theme="luna" 
let g:airline_powerline_fonts = 1   
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:Powerline_symbols="fancy"
if (has("gui_running"))
    let g:airline_left_sep = "\ue0b8"
    let g:airline_left_alt_sep = "\ue0b9"
    let g:airline_right_sep = "\ue0ba"
    let g:airline_right_alt_sep = "\ue0bb"
endif
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
map <Leader>1 :b 1<CR>
map <Leader>2 :b 2<CR>
map <Leader>3 :b 3<CR>
map <Leader>4 :b 4<CR>
map <Leader>5 :b 5<CR>
map <Leader>6 :b 6<CR>
map <Leader>7 :b 7<CR>
map <Leader>8 :b 8<CR>
map <Leader>9 :b 9<CR>


"IndentLine(缩进对齐线)
let g:indentLine_enabled = 1
let g:indentLine_char = '¦'


"更改Fullscreen映射 <F11>
nmap <silent> <F11> <Plug>(fullscreen-toggle)
imap <silent> <F11> <Esc> <Plug>(fullscreen-toggle)


"Startify (启动界面)
let g:startify_padding_left = 4
let g:startify_disable_at_vimenter = 0
let g:startify_bookmarks = [
            \ '~/.vimrc',
            \ '~/.zshrc',
            \ '~/.conkyrc',
            \ '~/script/Clean.sh',
            \ '~/script/SORA.py']
let g:startify_custom_header =
            \ startify#fortune#cowsay('═','║','╔','╗','╝','╚')
let g:startify_list_order = [
            \ ['   Oh! My Holy Working Directory!'],
            \ 'dir',
            \ ['   Recently Used Files'],
            \ 'files',
            \ ['   My Bookmarks:'],
            \ 'bookmarks',
            \ ]
let g:startify_custom_footer =
            \ ['', "   Happy Viming!!"]
autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)


"YouCompleteMe (自动代码补全)
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1


"ALE (代码异步检测)
let g:ale_sign_column_always = 1
let g:ale_sign_error = '汪'
let g:ale_sign_warning = '喵'
let g:ale_echo_msg_error_str = '汪汪汪！'
let g:ale_echo_msg_warning_str = '喵喵喵？'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'c': ['clang'],
                    \'c++': ['clang'],
                    \'Bash': ['shell'],
                    \'Python': ['flake8'],
                    \'Vim': ['vint']
                    \}
let g:ale_python_flake8_executable = 'python'
let g:ale_python_flake8_args = '-m flake8'
if !hlexists('ALEErrorSign')
    highlight link ALEErrorSign todo
endif


"有道翻译 <Leader>(d|t|r) 命令行/窗口/替换
let g:api_key = "1932136763"
let g:keyfrom = "aioiyuuko"
nmap <silent> <Leader>d <Plug>DictSearch
vmap <silent> <Leader>d <Plug>DictVSearch
nmap <silent> <Leader>t <Plug>DictWSearch
vmap <silent> <Leader>t <Plug>DictWVSearch
nmap <silent> <Leader>r <Plug>DictRSearch
vmap <silent> <Leader>r <Plug>DictRVSearch
" 'q' 关闭Dict窗口


":Project命令 进入C++项目工作空间, 若不存在则创建
"需要 pbrisbin/vim-mkdir 插件支持
if !exists(':Project')
    command! -nargs=1 Project call EnterProject(<q-args>)
endif
function! EnterProject(name) abort
    silent execute "vi ~/Projects/" . a:name . "/main.cpp"
    silent execute "w"
    silent execute "cd ~/Projects/" . a:name
    echo "已进入该项目, 位于 ~/Projects/" . a:name . "\Happy Coding!"
endfunction


":Test命令 在当前目录下创建输入文件
if !exists(':Test')
    command! -nargs=0 Test silent execute "vi inTest.txt"
endif
if !exists(':Notest')
    command! -nargs=0 Notest call CleanTest()
endif
function! CleanTest()
    silent g/inTest\|outTest/d
    silent! %s/tcin >>/cin >>/g
    silent! %s/tcout <</cout <</g
endfunction


"编译 & 连接选项 <C-(F7|F9)>为手动执行命令
autocmd FileType c call C_CompileOptions()
autocmd FileType cpp,cxx call CPP_CompileOptions()
autocmd FileType sh call SH_CompileOptions()
autocmd FileType python call PYHTON_CompileOptions()

function! C_CompileOptions() " Use LLVM/Clang Compiler
    let b:CompileCommand = "AsyncRun clang -std=c14 -Wall -O1 -c %"
    let b:LinkCommand    = "!clang ./*.o -o Run"
    let b:RunCommand     = "!time ./Run"
    map <C-F7> :AsyncRun clang -std=c14 -Wall -g -O1 -c %
    imap <C-F7> <Esc> <C-F7>
    map <C-F9> :!clang ./*.o -o Run && time ./Run
    imap <C-F9> <Esc> <C-F9>
endfunction

" function! CPP_CompileOptions() " Use GCC Compiler
"     let b:CompileCommand = "AsyncRun g++ -std=c++14 -Wall -O1 -c %"
"     let b:LinkCommand    = "!g++ ./*.o -o Run"
"     let b:RunCommand     = "!time ./Run"
"     map <C-F7> :AsyncRun g++ -std=c++14 -Wall -g -O1 -c %
"     imap <C-F7> <Esc> <C-F7>
"     map <C-F9> :!g++ ./*.o -o Run && time ./Run
"     imap <C-F9> <Esc> <C-F9>
" endfunction

function! CPP_CompileOptions() " Use LLVM/Clang Compiler
    let b:CompileCommand = "AsyncRun clang++ -std=c++14 -stdlib=libc++ -Wall -Weffc++ -O1 -c %"
    let b:LinkCommand    = "!clang++ -lc++ -lc++abi ./*.o -o Run"
    let b:RunCommand     = "!./Run"
    map <C-F7> :AsyncRun clang++ -std=c++14 -stdlib=libc++ -Weverything -g -O1 -c %
    imap <C-F7> <Esc> <C-F7>
    map <C-F9> :!clang++ -lc++ -lc++abi ./*.o -o Run && time ./Run
    imap <C-F9> <Esc> <C-F9>
endfunction

function! SH_CompileOptions()
    let b:RunCommand = "!bash %"
    map <C-F9> :!bash %
    imap <C-F9> <Esc> :!bash %
endfunction

function! PYHTON_CompileOptions()
    let b:RunCommand = "!python3 %"
    map <C-F9> :!python3 %
    imap <C-F9> <Esc> :!python3 %
endfunction


"AsyncRun(异步编译) <F7> <C-F7>
"保存并编译生成目标文件
map <silent> <F7> :call AsyncCompile()<CR>
imap <silent> <F7> <Esc> :call AsyncCompile()<CR>
function! AsyncCompile()
    if exists('b:CompileCommand')
        execute "w"
        execute b:CompileCommand
        execute "TagbarClose"
        let g:quickfix_return_to_window = winnr()
        execute "copen 8"
        let g:quickfix_is_open = 1
        execute g:quickfix_return_to_window . "wincmd w"
    else
        echo "当前文件并不能编译.. ╮(￣▽￣)╭"
    endif
endfunction


"Debug <F8> 保存编译并调试
map <silent> <F8> :call Debug()<CR>
imap <silent> <F8> <Esc> :call Debug()<CR>
function! Debug()
    if exists('b:CompileCommand')
        execute "w"
        execute b:CompileCommand
        execute "!gdb ./%<.o"
        echohl WarningMsg | echo "Debug Finish! _(:з」∠)_"
    else
        echo "只能调试C/C++程序呦.. ╮(￣▽￣)╭"
    endif
endfunction


"Link & Run <F9> <C-F9>
"链接当前目录的所有目标文件, 生成可执行文件并运行
map <silent> <F9> :call Link_Run()<CR>
imap <silent> <F9> <Esc> :call Link_Run()<CR>
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


"清除当前目录的所有目标文件及可执行文件 <F10>
map <silent> <F10> :call CleanObjFile()<CR>
imap <silent> <F10> <Esc> :call CleanObjFile()<CR>
function! CleanObjFile()
    if(has("win32") || has("win64"))
        execute "!del /q *.o Run.exe"
    else
        execute "!rm ./*.o ./Run"
    endif
    echohl WarningMsg | echo "Cleaning Successfully! (ﾉ･ω･)ﾉﾞ"
endfunction

if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
