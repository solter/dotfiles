"++++++++general parameter settings+++++++++
"Grab plugins
execute pathogen#infect()

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

"always have a status line
set laststatus=2

"map window-d (<C-w><C-d>) to open up file explorer
nmap <silent> <C-W><C-D> :vertical topleft 25split .<CR>

"enable pathogen to dig up mods in .vim/bundle
execute pathogen#infect()

"+++++++++specific parameters for different types of files
"Make fortran free form, not fixed
let fortran_free_source = 1

"force vim to use bash shell, not other stuff
let g:is_bash = 1

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

"status line
set statusline=%<\ %F\ %h%r%{SyntasticStatuslineFlag()}%m%=%-14.(%l,%c%V%)\ %P

"+++Syntastic settings
let g:syntastic_stl_format = '[%E{%e Err}%B{ : }%W{%w Warn}]'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 3
"switch to 2 if don't want the errors window popping up automatically
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_error_symbol = '>>'
let g:syntastic_warning_symbol = '>'
let g:syntastic_style_error_symbol = '**'
let g:syntastic_style_warning_symbol = '*'
"screw mouse support
let g:syntastic_enable_balloons = 0
"disable highlighting due to it sometimes not identifying
"where in the line, so just highlights the beginning of the line.
"Since there is still the error sidebar this is ok
let g:syntastic_enable_highlighting = 0
let g:syntastic_mode_map = {
  \ "mode": "active",
  \ "active_filetypes": [],
  \ "passive_filetypes": [] }
let g:syntastic_shell = "/bin/bash"

"+++NERDTree settings
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeDirArrows=0

"+++Tagbar settings
nnoremap ,t TagbarTogglePause
let g:tagbar_width = 30
let g:tagbar_sort = 0
let g:tagbar_iconchars = ['+', '-']
let g:tagbar_autoshowtag = 1
autocmd FileType * nested :call tagbar#autoopen(0)
let g:tagbar_status_func = 'rcfunc#TagbarStatusFunc'
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif

"Opens up NERDTree and tagbar if tags exist
let &tags="./.tags,"
"add root directory containing arch tags if it exists
au VimEnter *.* :call rcfunc#Setup_tags()

"When a new window is entered
autocmd BufEnter __Tagbar__  :call rcfunc#killIDE()
autocmd BufEnter NERD_tree*  :call rcfunc#killIDE()

"ycm settings
nnoremap <C-0> :YcmCompleter GoToImprecise<CR>
nnoremap <leader>yc :YcmCompleter<CR>
nnoremap <C-0> :YcmCompleter GetDoc<CR>
let g:ycm_show_diagnostics_ui = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_goto_buffer_command = 'horizontal-split'

"settings for the preview eindow
let g:completeopt = 'menuone,menu,preview'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

augroup indent_settings
  "auto-folds with indents
  au BufReadPre * setlocal foldmethod=indent
  "save folds when closing
  au BufWinLeave *.* mkview
  au BufWinEnter *.* silent loadview
  "set up indent guides
  let g:indent_guides_auto_colors=0
  autocmd VimEnter,Colorscheme * hi IndentGuidesEven ctermbg=5
  let g:indent_guides_start_level=2
  let g:indent_guides_guide_size=1
  let g:indent_guides_enable_on_vim_startup=1
  let g:indent_guides_default_mapping = 0
augroup END

"turn on search highlighting - and reset the highlight to null when window refreshed
set hlsearch
nnoremap <silent> <C-I> :nohl <CR> :IndentGuidesEnable <CR>
nnoremap <C-S> :syntax sync fromstart <CR>

