if index(keys(g:iron_repl_def), "sh") == -1
  let g:iron_repl_def["sh"] = &shell
endif

function! IronFormat(lines)
  let kwargs = {"exceptions": ["else", "then", "do", "elif", "#"]}
  let repl_text = iron#core#format(a:lines, kwargs)
  call iron#helpers#debug_log("sh", repl_text)
  return repl_text
endfunction
