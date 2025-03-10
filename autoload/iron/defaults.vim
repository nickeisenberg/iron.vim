" defaults for iron_repl_def are in ftplugin

function! iron#defaults#defaults()
  let defaults = {}
  let defaults["repl_open_cmd"] = {
    \ 'vertical': iron#view#repl_open_cmd('vertical rightbelow', 0.4),
    \ 'horizontal': iron#view#repl_open_cmd('rightbelow', 0.25),
  \}
  let defaults["iron_keymaps"] = {
    \ "toggle_repl": "<space>rr",
    \ "toggle_vertical": "<space>rv",
    \ "toggle_horizontal": "<space>rh",
    \ "repl_restart": "<space>rR",
    \ "repl_kill": "<space>rk",
    \ "send_line": "<space>sl",
    \ "send_visual": "<space>sp",
    \ "send_paragraph": "<space>sp",
    \ "send_until_cursor": "<space>su",
    \ "send_file": "<space>sf",
    \ "send_cancel": "<space>sc",
    \ "send_blank_line": "<space>s<CR>",
    \ }
  return defaults
endfunction
