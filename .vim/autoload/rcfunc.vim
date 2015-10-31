"auto indent guide
"needs indent guides - see github repo at https://github.com/nathanaelkane/vim-indent-guides
"restrict this to python by replacing *.* with *.py
function! rcfunc#Setup_IG ()
  let g:indent_guides_auto_colors=0
  "hi IndentGuidesOdd ctermbg=5
  hi IndentGuidesEven ctermbg=5
  let g:indent_guides_start_level=2
  let g:indent_guides_guide_size=1
  let g:indent_guides_enable_on_vim_startup=1
endfunction

"Deals with makefiles
function! rcfunc#Setup_Makefiles ()
  setfiletype make
  set noexpandtab "use real tabs since makefile is stupid
endfunction

"Sets tag variables and opens up windows
function! rcfunc#Setup_tags ()
  if g:ide
  "if it has a tags file
  if strlen(findfile('tags',"."))
      "for every directory above that has a .git folder
      let &tags="./tags,"
      for rootDirs in finddir(".git",".;~solfest/workspace",-1)
        "add that directory to tags
        let &tags .= rootDirs[0:-5] . ","
      endfor
      :TlistOpen
      "TODO: figure out how to open up file explorer
  endif
  endif
endfunction
