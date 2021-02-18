" function that will set up indents to arbitrary widths without tabstop
function rcfunc#SetIndentLevel(width)
  let &expandtab=1
  let &shiftwidth=a:width
  let &softtabstop=a:width
  let &tabstop=a:width
endfunction

" make the tab key perform autocompletion (see :help compl-whole-line)
function! rcfunc#CleverTab()
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    " insert a tab if at the beginning of a line (or it only has whitespace)
    return "\<Tab>"
  else
    " autocomplete otherwise
    return "\<C-N>"
  endif 
endfunction 

"Sets tag variables and opens up windows
function! rcfunc#FindTags ()
  " create a list of the current tags
  let my_tags = split(&tags, ",")

  " find all tag files for the repo (assuming the name is .tags)
  for tag_file in findfile(".tags", ".;/home/$USER;.git;", -1)
    " add absolute path of tags files to the tag list (see fnamemodify, filename-modifiers)
    add(my_tags, fnamemodify(tag_file, ":p"))
  endfor

  " sort the tags and remove duplicate entries
  " TODO: figure out if there's a way to to this without messing up the order
  call uniq(sort(my_tags))

  " repopulate the tag list
  let &tags = ""
  for tag_file in my_tags
    let &tags .= tag_file . ","
  endfor
endfunction        

function! rcfunc#TagbarStatusFunc(current, sort, fname, ...) abort
    let colour = a:current ? '%#StatusLine#' : '%#StatusLineNC#'
    return colour . "+=TAGS=+" . a:fname . '%= [' . a:sort . '] ' 
endfunction
