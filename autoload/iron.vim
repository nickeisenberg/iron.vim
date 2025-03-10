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
    \ "repl_restart": ["n", ":IronRestart<CR>"],
    \ "repl_kill": ["n", ":IronKill<CR>"],
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
    \ "send_cancel": [
      \ "n",
      \ ":call iron#core#send(\"\\x03\")<CR>",
      \ ],
    \ "send_blank_line": [
      \ "n",
      \ ":call iron#core#send(\"\\r\")<CR>",
      \ ],
    \ }

  let g:iron_repl_meta = {}  " memory for active repls

  command! IronRepl call iron#core#toggle_repl('toggle')
  command! IronKill call iron#core#kill_repl()
  command! IronRestart call iron#core#restart_repl()

  if !exists("g:iron_repl_def")
    let g:iron_repl_def = {}  " defaults are set in ftplugin
  endif
  
  let g:iron_repl_debug_log = a:opts["repl_debug_log"]
  let g:iron_term_wait = a:opts["term_wait"]
  let g:iron_repl_open_cmd = a:opts["repl_open_cmd"]

  for key in keys(g:iron_repl_open_cmd)
    if index(keys(a:opts["keymaps"]), "toggle_" . key) == -1
      throw "iron.vim ERROR: Keymap for toggle_" . key " if not defined"
    endif
  endfor

  for key in keys(g:iron_repl_open_cmd)
    let toggle_command = ":call iron#core#toggle_repl('". key . "')<CR>"
    let named_maps["toggle_" . key] = ["n", toggle_command]
  endfor

  for named_map in keys(a:opts["keymaps"])
    let mode = named_maps[named_map][0]
    let key = a:opts["keymaps"][named_map]
    let key_command = named_maps[named_map][1]
    execute mode . "noremap " . key . " " . key_command
  endfor
endfunction
