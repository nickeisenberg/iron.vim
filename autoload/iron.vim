function! iron#setup(opts)
  function! s:SetKeyMapping(mode, key, command)
      execute a:mode . "noremap " . a:key . " " . a:command
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

  let g:iron_repl_split_type = a:opts["iron_repl_split_type"]
  let g:iron_repl_def = a:opts["iron_repl_def"]
  let g:iron_repl_open_cmd = a:opts["iron_repl_open_cmd"]
  let g:iron_repl_size = a:opts["iron_repl_size"]

  for named_map in keys(a:opts["keymaps"])
    let mode = named_maps[named_map][0]
    let key = a:opts["keymaps"][named_map]
    let command = named_maps[named_map][1]
    call s:SetKeyMapping(mode, key, command)
  endfor
endfunction
