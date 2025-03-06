" defaults for iron_repl_def are in ftplugin

function! iron#defaults#defaults()
  let defaults = {}
  let defaults["repl_open_cmd"] = {
    \ 'vertical': 'vert rightbelow',
    \ 'horizontal': 'rightbelow',
  \}
  let defaults["repl_size"] = {
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
