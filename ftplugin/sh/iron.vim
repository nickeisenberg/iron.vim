function! IronFormat(lines)
  let kwargs = {"exceptions": ["else", "then", "do", "elif", "#", "}"]}
  let repl_text = iron#core#format(a:lines, kwargs)
  call writefile([repl_text], expand("~/iron_debug.log"), "a")
  return repl_text
endfunction
