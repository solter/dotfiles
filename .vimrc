"++++++++general parameter settings+++++++++
"tab spacing
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

"turn on line numbers 
set number

"set color scheme to use
colorscheme peachpuff_custom

"turn on syntax highlighting
syntax enable

"preserve tabbing from 1 line to the next
set autoindent

"auto indent based upon syntax
filetype on
filetype plugin indent on
filetype plugin on

"open split windows below and to the right rather than above and left
set splitbelow
set splitright

"set window resizing tools
nnoremap <C-j> :resize +3<CR>
nnoremap <C-k> :resize -3<CR>
nnoremap <C-h> :vertical resize -3<CR>
nnoremap <C-l> :vertical resize +3<CR>

"map window-d (<C-w><C-d>) to open up file explorer
nmap <silent> <C-W><C-D> :vertical topleft 25split .<CR>

"Opens up NERDTree and taglist if tags exist
let Tlist_Use_Right_Window = 1
let Tlist_Auto_Update = 1
let Tlist_Auto_Highlight_Tag = 1
let Tlist_WinWidth = 25
if !exists("g:ide")
  let g:ide = 1
endif
if g:ide
  au BufWinEnter *.* :call rcfunc#Setup_tags()
endif

"enable pathogen to dig up mods in .vim/bundle
execute pathogen#infect()

"+++++++++specific parameters for different types of files
"Make fortran free form, not fixed
let fortran_free_source = 1

"force vim to use bash shell, not other stuff
let g:is_bash = 1

"update tag file
"command description
"%:p:h - % -> current file, :p -> full path name, :h -> head (exclude file name)
nnoremap ,t !(cd %:p:h; if [ -e 'tags' ] then; ctags *; fi )&

augroup indent_settings
  "auto-folds with indents
  au BufReadPre * setlocal foldmethod=indent
  "save folds when closing
  au BufWinLeave *.* mkview
  au BufWinEnter *.* silent loadview
  "set up indent guides
  au VimEnter,Colorscheme *.* :call rcfunc#Setup_IG()
augroup END

"adjust split sizes to stay porportional when window is resized
"autocmd VimResized *.* set noea "toggles equal width off
"autocmd VimResized *.* set ea "toggles equal width on
"autocmd VimResized *.* :call resWin()

"turn on search highlighting - and reset the highlight to null when window refreshed
set hlsearch
nnoremap <C-I> :nohl<CR>
nnoremap <C-S> :syntax sync fromstart <CR>

"define filetypes
augroup filetypedetect
  au! BufNewFile,BufRead *.f90? setfiletype fortran
  au! BufNewFile,BufRead *.pyf setfiletype fortran
  au! BufNewFile,BufRead Make* :call rcfunc#Setup_Makefiles()
  au! BufNewFile,BufRead .bash* setfiletype sh
  au! BufNewFile,BufRead *.vim setfiletype vim
  au! BufNewFile,BufRead *.py setfiletype python
  au! BufNewFile,BufRead *.json setfiletype json
augroup END

"activate pylint checker
au FileType python compiler pylint
