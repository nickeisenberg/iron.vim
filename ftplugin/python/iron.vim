function! IronFormat(lines)
  let kwargs = {"exceptions": ["else", "elif", "except", "finally", "#"]}
  return iron#core#format(a:lines, kwargs)
endfunction
