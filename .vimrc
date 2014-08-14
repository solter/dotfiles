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

"set background=dark
"let g:solarized_termcolors=256
colorscheme default

"turn on line numbers
set number

"open split windows below and to the right rather than above and left
set splitbelow
set splitright

"function which opens vim file browser with some different options than standard
function! OpenFE ()
  set nosplitright
  20vsplit .
  set nonumber
  set splitright
endfunction

"map window-d (<C-w><C-d>) to open up directory
nmap <silent> <C-W><C-D> :call OpenFE()<CR>
map <C-W>, <C-W><
map <C-W>. <C-W>>


"save folds when closing
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

"auto-folds with indents
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  "au BufWinEnter *^.py if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

"auto indent guide
"needs indent guides - see github repo at https://github.com/nathanaelkane/vim-indent-guides
"restrict this to python by replacing *.* with *.py
function! Setup_IG ()
  let g:indent_guides_auto_colors=0
  hi IndentGuidesOdd ctermbg=5
  "hi IndentGuidesEven ctermbg=0
  let g:indent_guides_start_level=3
  let g:indent_guides_guide_size=1
  IndentGuidesEnable
endfunction

"turn on syntax highlighting
syntax enable
autocmd VimEnter,Colorscheme *.* :call Setup_IG()

"adjust split sizes to stay porportional when window is resized
autocmd VimResized *.* set noea "toggles equal width off
autocmd VimResized *.* set ea "toggles equal width on

"turn on search highlighting - and reset the highlight to null when window refreshed
set hlsearch
nnoremap <silent> <C-l> :nohl<CR><C-l>

augroup filetypedetect
  au! BufNewFile,BufRead *.m :set filetype=octave
  au! BufNewFile,BufRead *.f90? :set filetype=fortran
augroup END

" Use keywords from Octave syntax language file for autocomplete 
if has("autocmd") && exists("+omnifunc") 
   autocmd Filetype octave 
   \if &omnifunc == "" | 
   \  setlocal omnifunc=syntaxcomplete#Complete | 
   \endif 
endif 
