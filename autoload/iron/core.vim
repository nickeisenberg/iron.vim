function! s:GetReplSizeCmd(split_type)
  return {
    \ 'vertical': 'vertical resize ' . &columns * g:iron_repl_size["vertical"],
    \ 'horizontal': 'resize ' . &lines * g:iron_repl_size["horizontal"],
  \}[a:split_type] 
endfunction


function! iron#core#toggle_repl(split_type)
  if a:split_type != "toggle"
    let g:iron_repl_split_type = a:split_type
  endif

  let current_win_id = win_getid()
  let ft = &filetype
  let g:iron_ft = &filetype


  if g:iron_repl_buf_id > 0
    let win_id = bufwinnr(g:iron_repl_buf_id)

    if win_id > 0
      execute win_id . "wincmd c"
      return

    else
      execute g:iron_repl_open_cmd[g:iron_repl_split_type] . " sbuffer " . g:iron_repl_buf_id 
      execute s:GetReplSizeCmd(g:iron_repl_split_type)
    endif

  else
    execute g:iron_repl_open_cmd[g:iron_repl_split_type] . " term"
    execute s:GetReplSizeCmd(g:iron_repl_split_type)

    let g:iron_repl_buf_id = bufnr('%')

    if has_key(g:iron_repl_def, ft)
      call term_sendkeys(g:iron_repl_buf_id, g:iron_repl_def[ft] . "\n")
    else
      call term_sendkeys(g:iron_repl_buf_id, ft . "\n")
    endif
 
    setlocal bufhidden=hide
    autocmd ExitPre * execute ':bd! ' . g:iron_repl_buf_id

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
  let insert_return = 0
  for line in a:lines
    if iron#helpers#string_is_empty(line) == 1
      continue
    endif

    if iron#helpers#string_is_indented(line) == 1
      let indent_open = 1

    elseif iron#helpers#starts_with_exception(line, exceptions)
      let indent_open = indent_open

    else
      if indent_open == 1
        let line = "\r" . line
        let indent_open = 0
      endif
    endif
  
    call add(result, line)
  endfor

  let formated_string = join(result, "\n") . "\n\r"
  return formated_string
endfunction


function! iron#core#send(lines)
  if g:iron_repl_buf_id == -1
    return
  endif

  if !exists('*IronFormat')
    return
  endif
  
  let formated_string = IronFormat(a:lines)

  call term_sendkeys(g:iron_repl_buf_id, formated_string)
endfunction
