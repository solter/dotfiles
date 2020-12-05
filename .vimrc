" if using vim without the packages feature, have pathogen
" pull in plugins
if !has("packages")
  call pathogen#infect("~/.vim/pack/standard/start/{})
endif

augroup display_settings
  " clean out the previous indent_guide_settings
  autocmd!

  "turn on line numbers 
  set number

  "set color scheme to use
  colorscheme default

  "turn on syntax highlighting
  syntax enable

  " highlight all matches when searching
  set hlsearch

  "status line
  set statusline=%<\ %F\ %h%r%m%=%-14.(%l,%c%V%)\ %P
  " always show the status line
  set laststatus=2

  "open split windows below and to the right rather than above and left
  set splitbelow
  set splitright

  "turn on search highlighting - and reset the highlight to null when window refreshed
  set hlsearch
augroup END

" reset highlighting
nnoremap <silent> <C-I> :nohl<CR>:syntax sync fromstart<CR>:IndentGuidesToggle<CR>:IndentGuidesToggle

" make the tab key perform autocompletion (see :help compl-whole-line)
inoremap <Tab> <C-R>=rcfunc#CleverTab()<CR>

" set window resizing tools
nnoremap <C-j> :resize +3<CR>
nnoremap <C-k> :resize -3<CR>
nnoremap <C-h> :vertical resize -3<CR>
nnoremap <C-l> :vertical resize +3<CR>

augroup fold_and_indent
  " clean out the previous indent_guide_settings
  autocmd!

  "preserve tabbing from 1 line to the next
  set autoindent

  "auto indent based upon syntax
  filetype plugin indent on

  " make folds happen based on language syntax
  set foldmethod=syntax

  " show the current fold state on the left
  set foldcolumn=0
augroup END
" set it up so the indent level is 2 by default
call rcfunc#SetIndentLevel(2)

augroup filetype_settings
    " clean out the previous indent_guide_settings
  autocmd!

  " force it to use bash for shell
  let g:is_bash=1
  " make sure json doesn't conceal characters
  let g:vim_json_syntax_conceal = 0

  autocmd BufNewFile,BufRead *.f* setfiletype fortran
  autocmd BufNewFile,BufRead .?bash* setfiletype sh
  autocmd BufNewFile,BufRead [Mm]ake* setfiletype make
  autocmd BufNewFile,BufRead *.vim setfiletype make
  autocmd BufNewFile,BufRead *.py setfiletype python

  # set up auto-formatters
  autocmd FileType xml setlocal equalprg=xmllint\ --format\ -
augroup END

" every time the file buffer is entered, rescan for tags
autocmd BufEnter * :call rcfunc#FindTags()

" ++ plugin settings ++

augroup indent_guide_settings
  " clean out the previous indent_guide_settings
  autocmd!

  # use a single character rather than the full space 
  let g:indent_guides_guide_size=1

  # make the colors more reasonable
  let g:indent_guides_auto_colors=0
  autocmd VimEnter,Colorscheme * :highlight IndentGuidesOdd  cmtermbg=none 
  autocmd VimEnter,Colorscheme * :highlight IndentGuidesEven cmtermbg=Cyan 

  " start using indent guides on startup 
  let g:indent_guides_enable_on_vim_startup=1
augroup END

augroup tagbar_settings
  " clean out the previous indent_guide_settings
  autocmd!

  " make the window smaller
  let g:tagbar_width = 30
  " make tags same order as in file
  let g:tagbar_sort = 0
  " use +/- instead of fancy arrows in tagbar
  let g:tagbar_iconchars = ['+', '-']
  " highlight the current tag in the file
  let g:tagbar_autoshowtag = 1

  " if not doing vimdiff, open TagBar automatically
  if !&diff
    autocmd FileType * nested :call tagbar#autoopen(0)
  endif

  let g:tagbar_status_func = 'rcfunc#TagbarStatusFunc'
augroup END
" shortcut to freeze the tagbar
nnoremap ,t TagbarTogglePause

augroup dir_tree_settings
    " clean out the previous indent_guide_settings
  autocmd!

  if exists("g:loaded_nerd_tree") && g:loaded_nerd_tree
    " if using NERDTree, use +/- instead of fancy arrows
    let g:NERDTreeDirArrowExapndable="+"
    let g:NERDTreeDirArrowCollapsible="-"
  else
    " change the default style to long
    let g:netrw_liststyle=1
    " make the hidden files anything that starts with a .
    let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'
  endif
augroup END
