function! s:GetReplSizeCmd(split_type)
  return {
    \ 'vertical': 'vertical resize ' . &columns * g:iron_repl_size["vertical"],
    \ 'horizontal': 'resize ' . &lines * g:iron_repl_size["horizontal"],
  \}[a:split_type] 
endfunction


function! iron#core#new_repl(split_type)
  let current_win_id = win_getid()

  let ft = &filetype
  if empty(ft)
    let ft = "_no_ft"
  endif

  execute g:iron_repl_open_cmd[g:iron_repl_split_type] . " term"
  execute s:GetReplSizeCmd(g:iron_repl_split_type)
  execute 'set filetype=iron_' . ft

  " this will be replaced with meta
  let g:iron_repl_buf_id[ft] = bufnr('%')

  let g:iron_repl_meta[ft] = {
    \ "buf_id": bufnr('%'),
    \ "buf_ft": 'iron_' . ft,
    \ "repl_open_cmd": g:iron_repl_open_cmd[g:iron_repl_split_type] . " term",
    \ "repl_size_cmd": s:GetReplSizeCmd(g:iron_repl_split_type),
    \}

  if ft == "_no_ft"
    let def = &shell . " --login"
    call term_sendkeys(g:iron_repl_buf_id[ft], def . "\n")
    let g:iron_repl_meta[ft]["repl_def"] = def 

  elseif has_key(g:iron_repl_def, ft)
    call term_sendkeys(g:iron_repl_buf_id[ft], g:iron_repl_def[ft] . "\n")
    let g:iron_repl_meta[ft]["repl_def"] = g:iron_repl_def[ft] . "\n"

  else
    call term_sendkeys(g:iron_repl_buf_id[ft], ft . "\n")
    let g:iron_repl_meta[ft]["repl_def"] = ft . "\n"
  endif
  
  setlocal bufhidden=hide

  for key in keys(g:iron_repl_buf_id)
    execute 'autocmd ExitPre * execute ":bd! " . g:iron_repl_buf_id["' . key . '"]'
  endfor

  call win_gotoid(current_win_id)
endfunction


function! iron#core#toggle_repl(split_type)
  if a:split_type != "toggle"
    let g:iron_repl_split_type = a:split_type
  endif

  let current_win_id = win_getid()

  let ft = &filetype
  if empty(ft)
    let ft = "_no_ft"
  endif

  " if g:iron_repl_buf_id > 0
  if index(keys(g:iron_repl_buf_id), ft) != -1
    let win_id = bufwinnr(g:iron_repl_buf_id[ft])

    if win_id > 0
      execute win_id . "wincmd c"
      return

    else
      execute g:iron_repl_open_cmd[g:iron_repl_split_type] . " sbuffer " . g:iron_repl_buf_id[ft]
      execute s:GetReplSizeCmd(g:iron_repl_split_type)
    endif

  else
    call iron#core#new_repl(a:split_type)

  endif

  call win_gotoid(current_win_id)
endfunction


function! iron#core#kill_repl()
  let ft = &filetype
  if empty(ft)
    let ft = "_no_ft"
  endif

  if index(keys(g:iron_repl_buf_id), ft) != -1
    execute ":bd! " . g:iron_repl_buf_id[ft]
    let _ = remove(g:iron_repl_buf_id , ft)
  endif
endfunction


function! iron#core#restart_repl(split_type)
  if a:split_type != "toggle"
    let g:iron_repl_split_type = a:split_type
  endif

  let current_win_id = win_getid()

  let ft = &filetype
  if empty(ft)
    let ft = "_no_ft"
  endif

  " if g:iron_repl_buf_id > 0
  if index(keys(g:iron_repl_buf_id), ft) != -1
    let win_id = bufwinnr(g:iron_repl_buf_id[ft])

    if win_id > 0
      execute win_id . "wincmd c"
      return

    else
      execute g:iron_repl_open_cmd[g:iron_repl_split_type] . " sbuffer " . g:iron_repl_buf_id[ft]
      execute s:GetReplSizeCmd(g:iron_repl_split_type)
    endif

  else
    call iron#core#new_repl(a:split_type)

  endif

  call win_gotoid(current_win_id)
endfunction


function! iron#core#format(lines, kwargs)
  let result = []

  if has_key(a:kwargs, "cmd")
    let cmd = kwargs["cmd"]
  endif 

  if has_key(a:kwargs, "exceptions")
    let exceptions = a:kwargs["exceptions"]
  endif 

  let indent_open = 0
  let insert_newline_on_return = 0
  for line in a:lines
    if iron#helpers#string_is_empty(line) == 1
      continue
    endif

    if iron#helpers#string_is_indented(line) == 1
      let indent_open = 1
      let insert_newline_on_return = 1

    elseif iron#helpers#starts_with_exception(line, exceptions)
      let indent_open = indent_open

    else  " string is not indented and does not start with an exception
      if indent_open == 1
        let line = "\r" . line
        let indent_open = 0
        let insert_newline_on_return = 1
      else
        let insert_newline_on_return = 0
      endif
    endif
  
    call add(result, line)
  endfor
  
  if insert_newline_on_return == 1 
    let formated_string = join(result, "\n") . "\n\r"
  else
    let formated_string = join(result, "\n") . "\r"
  endif

  return formated_string
endfunction


function! iron#core#send(lines)
  let ft = &filetype
  if empty(ft)
    let ft = "_no_ft"
  endif

  if index(keys(g:iron_repl_buf_id), ft)  == -1
    return
  endif

  if !exists('*IronFormat')
    return
  endif
  
  let formated_string = IronFormat(a:lines)

  call term_sendkeys(g:iron_repl_buf_id[ft], formated_string)
endfunction
