if index(keys(g:iron_repl_def), "python") == -1
  if !empty($VIRTUAL_ENV)
    let python_def = "source $VIRTUAL_ENV/bin/activate && clear && which python3 && python"

  else
    let python_def = "python3"
  endif

  let g:iron_repl_def["python"] = python_def
endif

function! IronFormat(lines)
  let kwargs = {"exceptions": ["else", "elif", "except", "finally", "#"]}
  return iron#core#format(a:lines, kwargs)
endfunction
