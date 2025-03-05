function! iron#setup(opts)
  function! s:ListsAreEqual(list1, list2)
      if len(a:list1) != len(a:list2)
          return 0  " Different lengths → not equal
      endif
  
      let sorted1 = sort(copy(a:list1))
      let sorted2 = sort(copy(a:list2))
  
      return sorted1 == sorted2

  endfunction
  let named_maps = {
    \ "toggle_repl": ["n", ":IronRepl<CR>"],
    \ "send_line": [
      \ "n",
      \ ":silent! normal! V<CR>:<C-u>call iron#core#send(getline(\"'<\", \"'>\"))<CR>",
      \ ],
    \ "send_visual": [
      \ "v",
      \ ":<C-u>call iron#core#send(getline(\"'<\", \"'>\"))<CR>",
      \ ],
    \ "send_paragraph": [
      \ "n",
      \ ":silent! normal! vip<CR>:<C-u>call iron#core#send(getline(\"'<\", \"'>\"))<CR>",
      \ ],
    \ "send_until_cursor": [
      \ "n",
      \ ":silent! normal! mAVgg<CR>:<C-u>call iron#core#send(getline(\"'<\", \"'>\"))<CR>`A",
      \ ],
    \ "send_file": [
      \ "n",
      \ ":silent! normal! mAggvG<CR>:<C-u>call iron#core#send(getline(\"'<\", \"'>\"))<CR>`A",
      \ ],
    \ }

  command! IronRepl call iron#core#toggle_repl('toggle')

  let g:iron_repl_def = a:opts["iron_repl_def"]
  let g:iron_repl_open_cmd = a:opts["iron_repl_open_cmd"]
  let g:iron_repl_size = a:opts["iron_repl_size"]
  let g:iron_repl_split_type = a:opts["iron_repl_split_type"]

  let are_equal = s:ListsAreEqual(keys(g:iron_repl_open_cmd), keys(g:iron_repl_size))
  if are_equal == 0
    let msg = "iron.vim ERROR: keys of g:iron_repl_open_cmd and "
    let msg = msg . "g:iron_repl_size must match"
    throw msg
  endif

  for key in keys(g:iron_repl_open_cmd)
    if index(keys(a:opts["iron_keymaps"]), "toggle_" . key) == -1
      throw "iron.vim ERROR: Keymap for toggle_" . key " if not defined"
    endif
  endfor

  if index(keys(g:iron_repl_open_cmd), g:iron_repl_split_type) == -1
    let msg = "iron.vim ERROR: Command for iron_repl_split_type = "
    let msg = msg . g:iron_repl_split_type . " does not exist in iron_repl_open_cmd."
    throw msg
  endif

  for key in keys(g:iron_repl_open_cmd)
    let toggle_command = ":call iron#core#toggle_repl('". key . "')<CR>"
    let named_maps["toggle_" . key] = ["n", toggle_command]
  endfor

  for named_map in keys(a:opts["iron_keymaps"])
    let mode = named_maps[named_map][0]
    let key = a:opts["iron_keymaps"][named_map]
    let key_command = named_maps[named_map][1]
    execute mode . "noremap " . key . " " . key_command
  endfor

  let g:iron_repl_buf_id = -1
endfunction
