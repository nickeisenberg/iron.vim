function! IronFormat(lines)
  let kwargs = {"exceptions": ["else", "then", "do", "elif", "#"]}
  return iron#core#format(a:lines, kwargs)
endfunction
