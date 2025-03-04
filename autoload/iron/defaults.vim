function! iron#defaults#defaults()
  let defaults = {}
  if !empty($VIRTUAL_ENV)
    let python_def = "source $VIRTUAL_ENV/bin/activate && clear && which python3 && python"
  else
    let python_def = "python3"
  endif
  let defaults["iron_repl_def"] = {
    \'sh': 'bash -l',
    \'vim': 'bash -l',
    \'python': python_def,
    \}
  let defaults["iron_repl_split_type"] = "vertical"
  let defaults["iron_repl_open_cmd"] = {
    \ 'vertical': 'vert rightbelow',
    \ 'horizontal': 'rightbelow',
  \}
  let defaults["iron_repl_size"] = {
    \ 'vertical': 0.4,
    \ 'horizontal': 0.25,
  \}
  let defaults["iron_keymaps"] = {
    \ "toggle_repl": "<space>rr",
    \ "toggle_vertical": "<space>rv",
    \ "toggle_horizontal": "<space>rh",
    \ "send_line": "<space>sl",
    \ "send_visual": "<space>sp",
    \ "send_paragraph": "<space>sp",
    \ "send_until_cursor": "<space>su",
    \ "send_file": "<space>sf",
    \ }
  return defaults
endfunction
