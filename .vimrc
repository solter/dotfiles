"tab spacing
set expandtab
set shiftwidth=2
set tabstop=2

"preserve tabbing from 1 line to the next
set autoindent

"enable pathogen to dig up mods in .vim/bundle
execute pathogen#infect()

"Make fortran free form, not fixed
let fortran_free_source=1

"turn on syntax highlighting
syntax enable
"set background=dark
"let g:solarized_termcolors=256
colorscheme default

"turn on line numbers
set number

"move between windows with ctrl-thing rather than ctr-w
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Octave Syntax
augroup filetypedetect
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END

" Use keywords from Octave syntax language file for autocomplete 
if has("autocmd") && exists("+omnifunc") 
   autocmd Filetype octave 
   \if &omnifunc == "" | 
   \  setlocal omnifunc=syntaxcomplete#Complete | 
   \endif 
endif 

"save folds when closing
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

"auto-folds with indents
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  "au BufWinEnter *^.py if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

"auto indent guide stuff in python
"needs indent guides - see github repo at https://github.com/nathanaelkane/vim-indent-guides
"restrict this to python by replacing *.* with *.py
autocmd VimEnter,Colorscheme *.* :let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme *.* :hi IndentGuidesOdd ctermbg=5
"autocmd VimEnter,Colorscheme *.* :hi IndentGuidesEven ctermbg=0
autocmd VimEnter,Colorscheme *.* :let g:indent_guides_start_level=3
autocmd VimEnter,Colorscheme *.* :let g:indent_guides_guide_size=1
autocmd VimEnter,Colorscheme *.* :IndentGuidesEnable

"adjust split sizes to stay porportional when window is resized
autocmd VimResized *.* set noea "toggles equal width off
autocmd VimResized *.* set ea "toggles equal width on
