"模仿Windows快捷键
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"配置<Leader>
let mapleader=','
let g:mapleader = ','

"打开配置文件
let $MYGVIMRC='$VIM/_vimrc'
nmap <leader>v :vi $MYGVIMRC<CR>

"界面配置
syntax on
set t_Co=256
set laststatus=2
colorscheme molokai2
set guifont=DejaVuSansMono\ NF:h12
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
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,latin1
set langmenu=zh_CN.utf-8
set helplang=CN
let $LANG = 'en_US.utf-8' 
language messages zh_CN.utf-8

"取消备份及交换文件
set nobackup
set noswapfile
set noundofile

"禁用<F1>及Alt
noremap <F1> <Esc>
set winaltkeys=no

"切换全屏<F11>
imap <F11> <Esc> :call ToggleFullscreen()<CR>

"方向键切换窗口
nmap <Left> <c-w>h
nmap <Down> <c-w>j
nmap <up> <c-w>k
nmap <right> <c-w>l

"增强光标移动
nmap H ^
omap H ^
nmap L $
omap L $

"插入模式快捷键映射
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-u> <Esc> u
inoremap jk <Esc>
inoremap JK <Esc>

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

"与Windows共享剪切
set clipboard+=unnamed

"自动载入
set autoread
set history=20

"默认操作路径
cd $VIM\..\Projects

"C/C++缩写词及代码片段补全 <C-CR>
imap <C-CR> +<Space><BS>
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
                \CLASSNAME(CLASSNAME const &) {}<CR>
                \virtual ~CLASSNAME() = default;<CR>
                \private:<CR>
                \<Esc>6k7==
                \:.,.+4s/CLASSNAME//g<Left><Left>
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
                \std::ifstream tcin("./inTest.txt");<CR><CR>
                \int main()<CR>
                \{}<Left><CR><CR><CR><CR><Up><Tab>
                \return 0;<Up><Up><Tab>

"自动插入代码模板及头文件保护符
autocmd BufNewFile *.c exec "normal icmain+\<Space>"
autocmd BufNewFile *.cpp exec "normal icppmain+\<Space>"
autocmd BufNewFile *.h execute "normal iguard+\<Space>"

"括号自动补全
inoremap ( ()<Esc>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap [ []<Esc>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

func ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunc

func QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "\\"
        return a:char
    elseif line[col - 1] == a:char
        return "\<Right>"
    else
        return a:char.a:char."\<Esc>i"
    endif
endfunc



"Vundle及Vim插件
call plug#begin('$VIM/vimfiles/bundle')
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'universal-ctags/ctags'
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/TogFullscreen.vim'
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
Plug 'ryanoasis/vim-devicons'
call plug#end()




"EasyMotion 配置
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 1
let g:EasyMotion_startofline = 0
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)


"平滑滚屏
noremap <silent> J :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> K :call smooth_scroll#up(&scroll, 0, 2)<CR>


"multiple-cursors 配置
set selection=inclusive
let g:multi_cursor_use_default_mapping=1
let g:multi_cursor_quit_key='<CR>'


"C++ 语法高亮
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1


"NERD_Tree 配置 <F5>
map <F5> :NERDTreeToggle<CR>
imap <F5> <Esc>:NERDTreeToggle<CR>
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\.o$', '\~$']
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeDirArrowExpandable = "\uf07b"
let g:NERDTreeDirArrowCollapsible = "\uf07c"
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"Nerd_Commenter(多行注释) 配置 <Leader>cc <Leader>c<Space>
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 0
let g:NERDTrimTrailingWhitespace = 1


"Ctags 配置
set autochdir
set tags+=$VIM/vim80/systags
set tags+=./tags


"TagBar 配置 <F6>
map <F6> :TagbarToggle<CR>
imap <F6> <Esc> :TagbarToggle<CR>
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
        execute "copen 8 | setl wrap"
        let g:quickfix_is_open = 1
    endif
endfunction


"AirLine配置 <Ctrl + Tab>
nmap <silent> <C-tab> :bn<CR>
let g:airline_theme="luna" 
let g:airline_powerline_fonts = 1   
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:Powerline_symbols="fancy"
let g:airline_left_sep = "\ue0b8"
let g:airline_left_alt_sep = "\ue0b9"
let g:airline_right_sep = "\ue0ba"
let g:airline_right_alt_sep = "\ue0bb"
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


"IndentLine 配置
let g:indentLine_enabled = 1
let g:indentLine_char = '¦'


"Startify (启动界面)
let g:startify_padding_left = 4
let g:startify_disable_at_vimenter = 0
let g:startify_custom_footer =
            \ ['', "   Happy Viming!!"]
autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)
let g:startify_custom_header =
            \ startify#fortune#cowsay('=','|','=','=','=','=')


"ALE 配置
let g:ale_sign_column_always = 1
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_set_quickfix = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_linters = {'c': ['clang'],
                    \'c++': ['clang']
                    \}
let g:ale_cpp_clang_options = '-std=c++17 -Wall'
let g:ale_cpp_clangtidy_checks = ['-*, clang-analyzer-*, modernize-*']
if !hlexists('ALEErrorSign')
    highlight link ALEErrorSign todo
endif
nmap <silent> N <Plug>(ale_next_wrap)
nmap <silent> P <Plug>(ale_previous_wrap)


":Test命令 在当前目录下创建输入文件
map <F4> :Test<CR>
imap <F4> <Esc> :Test<CR>
if !exists(':Test')
    command! -nargs=0 Test 20vsplit inTest.txt
endif
if !exists(':Notest')
    command! -nargs=0 Notest call CleanTest()
endif
function! CleanTest()
    silent g/inTest\|outTest/d
    silent! %s/tcin >>/cin >>/g
    silent! %s/tcout <</cout <</g
    silent execute "w"
endfunction


"编译 & 连接选项
autocmd FileType c call C_CompileOptions()
function! C_CompileOptions()
    let b:CompileCommand = "AsyncRun gcc -std=c99 -Wall -fexec-charset=GBK -g -O0 -c %"
    let b:RunCommand = "!gcc *.o -o Run.exe && Run.exe"
endfunction

autocmd FileType cpp call CPP_CompileOptions()
function! CPP_CompileOptions()
    let b:CompileCommand = "AsyncRun g++ -std=c++17 -Wall -fexec-charset=GBK -g -O0 -c %"
    let b:RunCommand = "!g++ *.o -o Run.exe && Run.exe"
endfunction


"AsyncRun(异步编译) 配置 <F7>
"保存并编译生成目标文件
map <F7> :call AsyncCompile()<CR>
imap <F7> <Esc> :call AsyncCompile()<CR>
function! AsyncCompile()
    if exists('b:CompileCommand')
        execute "w"
        execute b:CompileCommand
        execute "TagbarClose"
        let g:quickfix_return_to_window = winnr()
        execute "copen 8 | setl wrap"
        let g:quickfix_is_open = 1
        execute g:quickfix_return_to_window . "wincmd w"
    else
        echo "当前文件并不能编译.. ╮(￣▽￣)╭"
    endif
endfunction


"Debug <F8> 保存编译并调试
map <F8> :call Debug()<CR>
imap <F8> <Esc> :call Debug()<CR>
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


"Link & Run 配置 <F9>
"链接当前目录的所有目标文件, 生成可执行文件并运行
map <F9> :call Link_Run()<CR>
imap <F9> <Esc> :call Link_Run()<CR>
function! Link_Run()
    if g:quickfix_is_open
        execute g:quickfix_return_to_window . "wincmd w"
        execute "cclose"
        let g:quickfix_is_open = 0
    endif
    if exists('b:RunCommand')
        execute b:RunCommand
        echohl WarningMsg | echo "Running Finish! o(*≧▽≦)ツ"
    else
        echo "不是可执行文件.."
    endif
endfunction


"清除当前目录的所有目标文件及可执行文件 <F10>
map <F10> :call CleanObjFile()<CR>
imap <F10> <Esc> :call CleanObjFile()<CR>
function! CleanObjFile()
    silent execute "!del /q *.o Run.exe"
    echohl WarningMsg | echo "Cleaning Successfully!"
endfunction
