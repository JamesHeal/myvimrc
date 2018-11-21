let mapleader=";" 
set nocompatible              " required
filetype off " required
"python语法高亮
let python_highlight_all=1
syntax on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
"Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"代码折叠插件
Plugin 'tmhedberg/SimpylFold'
"自动缩进插件
Plugin 'vim-scripts/indentpython.vim'
"自动补全
Bundle 'Valloric/YouCompleteMe'
"每次保存文件时检查代码的语法
Plugin 'scrooloose/syntastic'
"PEP8风格检查
Plugin 'nvie/vim-flake8'
"配色方案
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
"文件浏览
Plugin 'scrooloose/nerdtree'
"用tab键打开文件树
Plugin 'jistr/vim-nerdtree-tabs'
"在vim中使用git命令
Plugin 'tpope/vim-fugitive'
"搜索文件
Plugin 'ctrlpvim/ctrlp.vim'
"查看当前文件的标签/函数/变量名
Plugin 'vim-scripts/taglist.vim'
"底部信息栏美化
Plugin 'Lokaltog/vim-powerline'
set laststatus=2
set t_Co=256
"let g:Powerline_symbols= 'unicode'
set encoding=utf8
"代码块自动补全
" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<cr>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on " required

"设置窗口分割的区域及快捷方式
set splitbelow
set splitright
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 开启代码折叠
set foldmethod=indent
set foldlevel=99
" 将代码折叠的快捷键改为空格键
nnoremap <space> za
"设置simplefold插件，使被折叠代码的文档字符串可见
let g:SimpylFold_docstring_preview=1

"设置.py文件的tab缩进为4个标准的空格符，确保每行代码长度不超过80个字符，并且会以unix格式储存文件
au BufNewFile,BufRead *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set textwidth=79 |
\ set expandtab |
\ set autoindent |
\ set fileformat=unix
"可以根据自己的编程需要设置其他语言的缩进
au BufNewFile,BufRead *.js, *.html, *.css
\ set tabstop=2
\ set softtabstop=2
\ set shiftwidth=2

"标示多余的空白字符
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"支持utf-8编码
set encoding=utf-8

"让自动补全窗口不消失
let g:ycm_autoclose_preview_window_after_completion=0
"回车选中当前项
"inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
"让vim的补全菜单行为与一般ide一致
set completeopt=longest,menu
"设置转到定义的快捷键为；+g
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"配色逻辑判断
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif
"按F5切换亮色和暗色
call togglebg#map("<F6>")

"文件树中隐藏.pyc文件
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
map <F2> :NERDTreeToggle<CR>
imap <F2> <ESC>:NERDTreeToggle<CR>

"开启行号
set nu

"设置自动补全的库以及配置文件
let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py:'
let g:ycm_confirm_extra_conf = 0 
" 引入，可以补全系统，以及python的第三方包 针对新老版本YCM做了兼容
" old version
if !empty(glob("~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"
endif
" new version
if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
     let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
endif

"在工作目录下的任一文件中使用ctrlp，都会搜索整个工作目录下的文件
let g:ctrlp_workding_path_mode='wa'
"设置ctrlp忽略目录以及部分后缀的文件
 let g:ctrlp_custom_ignore={
         \ 'dir': '\v[\/]\.(git|hg|svn)$',
         \ 'file': '\v\.(exe|so|dll|xls|xlsx|doc|docx|meta|bytes|ppt|pptx)$',
     \ }

"设置Taglist快捷键
noremap <F8> :TlistToggle<CR> 
"每次只显示一个文件的标签，工程较大时，如果显示所有文件的标签打开会很慢
let Tlist_Show_One_File=1 
"默认打开到窗口右侧，由于nerdtree已经占用了左侧窗口，taglist放到右侧，避免冲突
let Tlist_Use_Right_Window=1
"打开时光标放到taglist窗口，这样打开后可以直接挪动光标到对应的标签跳转，也可以直接按q退出taglist窗口
let Tlist_GainFocus_On_ToggleOpen=1
"选中标签后就关闭taglist窗口，个人喜好taglist只在要跳转时出现
let Tlist_Close_On_Select=1
"设置ctags路径，因为taglist是基于ctags的
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
"设置更新ctags标签文件快捷键
noremap <F6> :!ctags -R<CR>

"按F5运行python"
map <F5> :Autopep8<CR> :w<CR> :call RunPython()<CR>
function RunPython()
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = expand("%:t")
    setlocal makeprg=python\ -u
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    silent make %
    copen
    let &makeprg = mp
    let &errorformat = ef
endfunction

set cursorline      "突出显示当前行"
set showmatch   "显示匹配的括号"
