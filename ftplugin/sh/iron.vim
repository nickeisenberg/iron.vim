if index(keys(g:iron_repl_def), "sh") == -1
  let g:iron_repl_def["sh"] = [&shell]
endif

function! IronFormat(lines)
  let kwargs = {"exceptions": ["else", "then", "do", "elif", "#"]}
  let repl_text = iron#core#format(a:lines, kwargs)
  for line in repl_text
    call writefile([line], expand("~/iron_debug.log"), "a")
  endfor
  return repl_text
endfunction
