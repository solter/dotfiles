"Refreshes the buffer"
function! rcfunc#refresh ()
  nohl  
  IndentGuidesEnable
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
      "TODO: figure out the appropriate way to set up nerdtree and taglist
      NERDTree
  endif
  endif
endfunction

"Closes NERDTree and tagbar if they are all that's open
function! rcfunc#killIDE ()
    "Detects which are open
    if exists('t:NERDTreeBufName')
        let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
    else
        let nerdtree_open = 0
    endif
    let tagbar_open = bufwinnr('__Tagbar__') != -1

    "if the number of windows is less than tagbar and nerdtree (2)
    if winnr('$') <= tagbar_open + nerdtree_open
        quit
    endif
endfunction

"This gets the buffer count
function! rcfunc#bufCount()
    "The last buffer
    let i = bufnr('$')
    let j = 0
    while i >= 1
        "if
        if buflisted(i)
            let j+=1
        endif
        let i-=1
    endwhile
    return j
endfunction
