function! iron#view#fix_all_windows()
  let curbuf = bufnr('%')
  setlocal nowinfixwidth nowinfixheight
  for buf in range(1, bufnr('$'))
    if buf == curbuf
      continue
    endif
    " if getbufvar(buf, '&buftype') == 'terminal'
    "   continue
    " endif
    for win in win_findbuf(buf)
      call win_execute(win, 'setlocal winfixwidth winfixheight')
    endfor
  endfor
endfunction

 
function! iron#view#repl_open_cmd(split, size)
  let self = {"split": a:split, "size": a:size}

  function! self.get_cmd()
    if match(self["split"], "vert") != -1
      let size = winwidth(0) * self["size"]
    else
      let size = winheight(0) * self["size"]
    endif
    return self["split"] . " " . size
  endfunction

  return self
endfunction
