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


function! iron#core#send(lines)
  if g:iron_repl_buf_id == -1
    return
  endif

  if !exists('*Format')
    return
  endif
  
  let formated_string = Format(a:lines, {})

  call term_sendkeys(g:iron_repl_buf_id, formated_string)
endfunction

