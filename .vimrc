" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype on
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


"Set mapleader
let mapleader = ","
"Fast reloading of the .vimrc
map <silent> <leader>ss :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <silent> <leader>ee :e ~/.vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc 

set path=.,,/usr/include,/usr/local
source /usr/share/vim/vim73/ftplugin/man.vim

"解决中文乱码问题
set fileencodings=utf-8,gb2312,gbk,gb18030

"Runtime Path Manipulation
call pathogen#infect()

"设置行号
set number

"定义快捷键前缀
"let mapleader=";"

set t_Co=256
set ts=8
"http://www.ibm.com/developerworks/cn/linux/l-tip-vim3/

" first, enable status line always
set laststatus=2

" now set it up to change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif

"molokai color theme设置
colorscheme molokai
let g:molokai_original = 1

"taglist设置
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
"let Tlist_Use_Right_Window=1
let Tlist_File_Fold_Auto_Close=1
nmap tl :TlistToggle<cr>

"winManager设置
"let g:winManagerWindowLayout='FileExplorer|Taglist'
nmap wm :WMToggle<cr>

"设置cscope

set cscopequickfix=s-,c-,d-,i-,t-,e-
if has("cscope")	
	set csprg=/usr/bin/cscope
	set csto=0	
	set cst	
	set nocsverb	
	" add any database in current directory	
	if filereadable("cscope.out")	
	    cs add cscope.out	
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
	    cs add $CSCOPE_DB
	endif
	set csverb
endif	

"cscope快捷键
"map <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>
"map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
"map g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"quickfix
"切换到下一个
"nmap <F6> :cn<cr>
"切换到上一个
"nmap <F7> :cp<cr>

"minibuf设置
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1

"A.vim设置
nnoremap <silent> <F12> :A<CR>
nnoremap <silent> <F3> :Grep<CR> 

"new-omni-completion(全能补全)
"文件类型检测
"filetype plugin indent on
"关掉智能补全时的预览窗口
set completeopt=longest,menu

"supertab设置
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"

"tags设置
"example:ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f gl /usr/include/GL/   # for OpenGL
" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4
set tags+=~/.vim/tags/owntags
" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

"NerdTree设置
nmap fl :NERDTreeToggle<CR>
let NERDTreeWinPos="right"
"open a NERDTree automatically when vim starts up
"autocmd vimenter * NERDTree
"open a NERDTree automatically when vim starts up if no files were specified
autocmd vimenter * if !argc() | NERDTree | endif
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"SrcExl设置
"The switch of the Source Explorer 
"nmap <F8> :SrcExplToggle<CR> 
"Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 8 
"Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 100 
"Set "Enter" key to jump into the exact definition context 
let g:SrcExpl_jumpKey = "<ENTER>" 
"Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<SPACE>" 
"In order to Avoid conflicts, the Source Explorer should know what plugins 
"are using buffers. And you need add their bufname into the list below 
"according to the command ":buffers!" 
let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
        \ "_NERD_tree_", 
        \ "Source_Explorer",
	\ "[File List]",
	\ "[Buf List]"
    \ ] 
"Enable/Disable the local definition searching, and note that this is not 
"guaranteed to work, the Source Explorer doesn't check the syntax for now. 
"It only searches for a match with the keyword according to command 'gd' 
let g:SrcExpl_searchLocalDef = 1 
"Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 0 
"Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
"create/update a tags file 
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 
"Set "<F12>" key for updating the tags file artificially 
let g:SrcExpl_updateTagsKey = "<F12>" 

"Trinity设置
" Open and close all the three plugins on the same time 
nmap <F8>  :TrinityToggleAll<CR> 
" Open and close the Source Explorer separately 
nmap <F9>  :TrinityToggleSourceExplorer<CR> 
" Open and close the Taglist separately 
nmap <F10> :TrinityToggleTagList<CR> 
" Open and close the NERD Tree separately 
nmap <F11> :TrinityToggleNERDTree<CR> 









