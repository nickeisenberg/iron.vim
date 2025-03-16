if index(keys(g:iron_repl_def), "lua") == -1
  let g:iron_repl_def["lua"] = "lua"
endif


function! IronFormat(lines)
  let kwargs = {"exceptions": ["--"]}
  let repl_text = iron#core#format(a:lines, kwargs)
  call iron#helpers#debug_log("r", repl_text)
  return repl_text
endfunction
