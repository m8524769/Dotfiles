"模拟Windows快捷键并开启映射
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"配置<Leader>键
let mapleader=','
let g:mapleader = ","

"打开配置文件 <Leader>v <Leader>gv
let $MYVIMRC='~/.vimrc'
nmap <leader>v :split $MYVIMRC<Cr>

"界面配置
syntax on
set laststatus=2
set t_Co=256
if (has("gui_running"))
    colorscheme desert
    highlight Pmenu term=bold ctermbg=4 guibg=DarkGrey
    highlight PmenuSel term=bold ctermbg=4 guibg=Cyan
    " colorscheme solarized
    " colorscheme molokai
    " colorscheme wombat256
    " colorscheme lucius
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ Bold\ 12
    " set guifont=Sauce\ Code\ Powerline\ Regular\ 12
    " set guifont=Hack\ Bold\ 12
    set gfw=FZMiaoWuS-GB\ Regular\ 16
endif
set number
set nowrap
set shortmess=atI
set cursorcolumn
set cursorline
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
set fileencodings=ucs-bom,utf-8,utf-16,cp936,gb18030,big5,euc-jp,latin1
set langmenu=zh_CN.utf-8
set helplang=CN
let $LANG = 'en_US.utf-8' 
language messages zh_CN.utf-8
source$VIMRUNTIME/delmenu.vim
source$VIMRUNTIME/menu.vim

"取消备份及交换文件
set nobackup
set noswapfile
set noundofile

"禁用<F1>及Alt
nmap <F1> <Esc>
set winaltkeys=no

"方向键切换窗口
nmap <Left> <C-w>h
nmap <Down> <C-w>j
nmap <up> <C-w>k
nmap <right> <C-w>l

"增强光标移动
nmap H ^
nmap J }
nmap K {
nmap L $

"插入模式快捷键映射
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap <C-u> <Esc> u
imap jk <Esc>

"代码折叠
set foldenable
set foldmethod=syntax
set foldcolumn=0
set foldlevelstart=99

"与Linux共享剪切
set clipboard+=unnamed

"自动载入
set autoread
set history=200

"默认操作路径
cd /home/yk/Projects

"C/C++缩写词及代码片段补全 <C-CR>
imap <C-CR> +<Space><BS>
iabbrev ui+ unsigned int <Esc>==$a
iabbrev uc+ unsigned char <Esc>==$a
iabbrev p+ printf("");<Esc>==7la
iabbrev s+ scanf("", &);<Esc>==6la
iabbrev cout+ cout <<  << endl;<Esc>==7la
iabbrev cin+ cin <<  << endl;<Esc>==6la
iabbrev for+ for (; ; )<CR>
            \{}<Left><CR>
            \<Esc>2k3==wa
iabbrev do+ do<CR>
            \{}while ();
            \<Esc>k2==ja<CR><Esc>$hi
iabbrev switch+ switch ()<CR>
                \{}<Left><CR>
                \case '': <CR>
                \case '': <CR>
                \default: <CR>
                \<Esc>5k6==wa
iabbrev struct+ struct {};<Left><Left><CR><Esc>k2==wi
iabbrev union+ union {};<Left><Left><CR><Esc>k2==wi
iabbrev enum+ enum {};<Left><Left><CR><Esc>k2==wi
iabbrev class+ class CLASSNAME{};<Left><Left><CR>
                \public:<CR>
                \CLASSNAME() {}<CR>
                \~CLASSNAME() {}<CR>
                \private:<CR>
                \<Esc>5k6==w
iabbrev #+ #include <><Left>
iabbrev using+ using namespace <Esc>==$a
iabbrev guard+ #ifndef HEADER_FILE_H<CR>
                \#define HEADER_FILE_H<CR><CR>
                \#endif // HEADER_FILE_H<ESC>3kb
iabbrev cmain+ /* <C-r>=strftime("New at 20%y.%m.%d(%A) by yk")<CR> */<CR>
                \#include <stdio.h><CR><CR>
                \int main()<CR>
                \{}<Left><CR><CR><CR><CR><Up><Tab>
                \return 0;<Up><Up><Tab>
iabbrev cppmain+ /* <C-r>=strftime("New at 20%y.%m.%d(%A) by yk")<CR> */<CR>
                \#include <iostream><CR><CR>
                \using namespace std;<CR><CR>
                \int main()<CR>
                \{}<Left><CR><CR><CR><CR><Up><Tab>
                \return 0;<Up><Up><Tab>

"常用脚本缩写词
iabbrev shmain+ #!/bin/bash<CR><CR>
iabbrev pymain+ #!/usr/bin/python<CR><CR>

"自动插入代码模板及头文件保护符
autocmd BufNewFile *.c exec "normal icmain+\<Space>"
autocmd BufNewFile *.cpp exec "normal icppmain+\<Space>"
autocmd BufNewFile *.h exec "normal iguard\<C-CR>"
autocmd BufNewFile *.sh exec "normal ishmain+\<Space>"
autocmd BufNewFile *.py exec "normal ipymain+\<Space>"

"括号自动补全
inoremap ( ()<Esc>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap [ []<Esc>i
inoremap ] <c-r>=ClosePair(']')<CR>
" inoremap { {}<Esc>i
" inoremap } <c-r>=ClosePair('}')<CR>
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
filetype plugin on
set nocompatible
filetype off
set rtp+=$VIM/vimfiles/bundle/Vundle.vim
call vundle#begin('$VIM/vimfiles/bundle/')

Plugin 'http://github.com/VundleVim/Vundle.vim.git'

Plugin 'http://github.com/Shougo/unite.vim.git'
Plugin 'http://github.com/scrooloose/nerdtree.git'
Plugin 'http://github.com/scrooloose/nerdcommenter.git'
Plugin 'http://github.com/universal-ctags/ctags.git'
Plugin 'http://github.com/majutsushi/tagbar.git'
Plugin 'http://github.com/easymotion/vim-easymotion.git'
Plugin 'http://github.com/Valloric/YouCompleteMe.git'
Plugin 'http://github.com/vim-airline/vim-airline.git'
Plugin 'http://github.com/vim-airline/vim-airline-themes.git'
Plugin 'http://github.com/vim-scripts/a.vim.git'
Plugin 'http://github.com/lambdalisue/vim-fullscreen.git'
Plugin 'http://github.com/skywind3000/asyncrun.vim.git'
Plugin 'http://github.com/pbrisbin/vim-mkdir.git'
Plugin 'http://github.com/terryma/vim-multiple-cursors.git'
Plugin 'http://github.com/Yggdroot/indentLine.git'
Plugin 'http://github.com/w0rp/ale.git'
Plugin 'http://github.com/mhinz/vim-startify.git'

Plugin 'http://github.com/uguu-org/vim-matrix-screensaver.git'

call vundle#end()
filetype plugin indent on





"EasyMotion(快速跳转) 配置
let mapleader=','
let g:mapleader = ","
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


"multiple-cursors(多行编辑) 配置
set selection=inclusive
let g:multi_cursor_use_default_mapping=1
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<CR>'


"切换配色方案 <F4>
let g:Color = 1
let g:ColorList = { 0: "desert",
                \   1: "solarized",
                \   2: "molokai",
                \   3: "wombat256",
                \   4: "lucius"
                \   }
map <F4> :call SwitchColorscheme() <CR>
imap <F4> <Esc> :call SwitchColorscheme() <CR>
func! SwitchColorscheme()
    exec "colorscheme " g:ColorList[g:Color]
    let g:Color+=1
    if g:Color == 5
        let g:Color = 0
    endif
endfunc


"NERD_Tree(目录树) 配置 <F5>
map <F5> :NERDTreeToggle<CR>
inoremap <F5> <Esc> :NERDTreeToggle<CR>
" autocmd vimenter * NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'


"Nerd_Commenter(多行注释) 配置 <Leader>cc <Leader>c<Space>
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1


"Ctags(生成tags代码索引) 配置
set autochdir
set tags+=$VIM/vimfiles/systags
set tags+=./tags


"TagBar(函数列表) 配置 <F6>
map <F6> :TagbarToggle<CR>
inoremap <F6> <Esc> :TagbarToggle<CR>
let g:tagbar_ctags_bin='ctags'
let g:tagbar_width=30
" autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()


"Close_QuickFix(关闭编译信息窗口) <F2>
map <F2> :call CloseFX()<CR>
inoremap <F2> <Esc> :call CloseFX()<CR>
func! CloseFX()
	exec "cclose"
    exec "TagbarOpen"
endfunc


"AirLine(状态栏及缓冲区标签) 配置 <C-Tab> <Leader>[1-9]
noremap <C-tab> :bn<CR>
let g:airline_theme="luna" 
let g:airline_powerline_fonts = 1   
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:Powerline_symbols="fancy"
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


"IndentLine(缩进对齐线) 配置
let g:indentLine_enabled = 1
let g:indentLine_char = '¦'


"更改Fullscreen(全屏)映射 <F11>
if get(g:, 'fullscreen#enable_default_keymap', 1) == 1
  nmap <silent> <F11> <Plug>(fullscreen-toggle)
  imap <silent> <F11> <Esc> <Plug>(fullscreen-toggle)
endif


"Startify(启动界面) 配置
let g:startify_padding_left = 4
let g:startify_disable_at_vimenter = 0
autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)


"YouCompleteMe(自动代码补全) 配置
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1


"ALE(代码异步检测) 配置
let g:ale_sign_column_always = 1
let g:ale_sign_error = '汪'
let g:ale_sign_warning = '喵'
let g:ale_echo_msg_error_str = '汪'
let g:ale_echo_msg_warning_str = '喵'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'c': ['gcc'],
                    \'c++': ['gcc'],
                    \'Bash': ['shell'],
                    \'Python': ['flake8'],
                    \'Vim': ['vint']
                    \}
noremap <silent> <C-k> <Plug>(ale_previous_wrap)
noremap <silent> <C-j> <Plug>(ale_next_wrap)


"AsyncRun(异步编译) 配置 <F7>
map <F7> :call AsyncRun()<CR>
imap <F7> <Esc> :call AsyncRun()<CR>
func! AsyncRun()
	exec "w"
    if expand("%:e") == "c"
        exec "AsyncRun gcc -std=c11 -Wall -g -O0 -c % -o %<.o"
        exec "TagbarClose"
        echohl WarningMsg | echo "AsyncRun Done!"
    elseif expand("%:e") == "cpp"  
        exec "AsyncRun g++ -std=c++14 -Wall -g -O0 -c % -o %<.o"
        exec "TagbarClose"
        echohl WarningMsg | echo "AsyncRun Done!"
    endif
    exec "copen"
endfunc


"Debug 配置 <F8>
map <F8> :call Debug()<CR>
imap <F8> <Esc> :call Debug()<CR>
func! Debug()
    exec "w"
    if expand("%:e") == "c"
        exec "!gcc -std=c11 % -g -o %<.o"
        exec "!gdb %<.o"
        echohl WarningMsg | echo "Debug Done!"  	
    elseif expand("%:e") == "cpp"  
        exec "!g++ -std=c++14 % -g -o %<.o"
        exec "!gdb %<.o"
        echohl WarningMsg | echo "Debug Done!"  	
    endif
endfunc





if has("gui_running")  
    let g:isGUI = 1  
else  
    let g:isGUI = 0  
endif  

"一键保存,编译,连接并运行 <F9>
map <F9> :call Run()<CR>  
imap <F9> <ESC>:call Run()<CR>  

let s:LastShellReturn_C = 0  
let s:LastShellReturn_L = 0  
let s:ShowWarning = 1  
let s:Obj_Extension = '.o'  
let s:Sou_Error = 0  

let s:linux_CFlags = 'gcc\ -std=c11\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'  
let s:linux_CPPFlags = 'g++\ -std=c++14\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'  

func! Compile()  
    exe "w"
    exe ":ccl"  
    exe ":update"  
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"  
        let s:Sou_Error = 0  
        let s:LastShellReturn_C = 0  
        let Sou = expand("%:p")  
        let Obj = expand("%:p:r").s:Obj_Extension  
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension  
        let v:statusmsg = ''  
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))  
            redraw!  
            if expand("%:e") == "c"  
                exe ":setlocal makeprg=".s:linux_CFlags  
                echohl WarningMsg | echo " compiling..."  
                silent make  
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"  
                exe ":setlocal makeprg=".s:linux_CPPFlags  
                echohl WarningMsg | echo " compiling..."  
                silent make  
            endif  
            redraw!  
            if v:shell_error != 0  
                let s:LastShellReturn_C = v:shell_error  
            endif  
            if empty(v:statusmsg)  
                echohl WarningMsg | echo " compilation successful"  
            else  
                exe ":bo cope"  
            endif  
        else  
            echohl WarningMsg | echo ""Obj_Name"is up to date"  
        endif  
    else  
        let s:Sou_Error = 1  
        echohl WarningMsg | echo " please choose the correct source file"  
    endif  
    exe ":setlocal makeprg=make"  
endfunc  

func! Link()  
    call Compile()  
    if s:Sou_Error || s:LastShellReturn_C != 0  
        return  
    endif  
    let s:LastShellReturn_L = 0  
    let Sou = expand("%:p")  
    let Obj = expand("%:p:r").s:Obj_Extension  
    let Exe = expand("%:p:r")  
    let Exe_Name = expand("%:p:t:r")  
    let v:statusmsg = ''  
    if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))  
        redraw!  
        if !executable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))  
            if expand("%:e") == "c"  
                setlocal makeprg=gcc\ -o\ %<\ %<.o  
                echohl WarningMsg | echo " linking..."  
                silent make  
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"  
                setlocal makeprg=g++\ -o\ %<\ %<.o  
                echohl WarningMsg | echo " linking..."  
                silent make  
            endif  
            redraw!  
            if v:shell_error != 0  
                let s:LastShellReturn_L = v:shell_error  
            endif  
            if empty(v:statusmsg)  
                echohl WarningMsg | echo " linking successful"  
            else  
                exe ":bo cope"  
            endif  
        else  
            echohl WarningMsg | echo ""Exe_Name"is up to date"  
        endif  
    endif  
    setlocal makeprg=make  
endfunc  

func! Run()  
    let s:ShowWarning = 0  
    call Link()  
    let s:ShowWarning = 1  
    if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0  
        return  
    endif  
    let Sou = expand("%:p")  
    let Obj = expand("%:p:r").s:Obj_Extension  
    let Exe = expand("%:p:r")  
    if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)  
        redraw!  
        echohl WarningMsg | echo " running..."  
        if g:isGUI  
            exe ":!gnome-terminal -e ./%<"  
        else  
            exe ":!./%<"  
        endif  
        redraw!  
        echohl WarningMsg | echo " running finish"  
    endif  
endfunc  



runtime! debian.vim

if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
