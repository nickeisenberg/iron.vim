if index(keys(g:iron_repl_def), "vim") == -1
  let g:iron_repl_def["vim"] = &shell . ' --login' 
endif
