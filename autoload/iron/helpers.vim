" Checks in a substring exists in a string
"
" @param string  a sting
" @param substring  a phrase to look for in the substring
" @return  0 if no, 1 if yes
function! iron#contains(string, substring)
  if string =~ '\V' . substring 
    return 1
  else
    return 0 
  endif
endfunction

" Removes empty lines. On unix this includes lines only with whitespaces.
"
" @param lines  list - a list of lines
" @return  list of lines with all blank lines removed
function! iron#remove_empty_lines(lines)
  let newlines = []
  for line in a:lines
    if line =~# '^\s*$'
      continue
    endif
    call add(newlines, line)
  endfor
  return newlines
endfunction


" Checks if a string starts with any word in the 'exceptions' list (ignoring leading spaces).
"
" @param string  string - The input string
" @param exceptions  list - A list of strings to check if string starts with.
" @return  int - 1 if it starts with an exception, 0 otherwise
function! iron#starts_with_exception(string, exceptions)
  let trimmed_str = matchstr(a:string, '^\s*\zs.*')

  for exception in a:exceptions
    if trimmed_str =~# '^' . exception
      return 1
    endif
  endfor

  return 0
endfunction
