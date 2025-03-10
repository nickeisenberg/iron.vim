" defaults for iron_repl_def are in ftplugin

function! iron#defaults#defaults()
  let defaults = {}
  let defaults["repl_debug_log"] = 0
  let defaults["repl_open_cmd"] = {
    \ 'vertical': iron#view#repl_open_cmd('vertical rightbelow', 0.4),
    \ 'horizontal': iron#view#repl_open_cmd('rightbelow', 0.25),
  \}
  let defaults["term_wait"] = 0
  let defaults["keymaps"] = {
    \ "toggle_repl": "<leader>rr",
    \ "toggle_vertical": "<leader>rv",
    \ "toggle_horizontal": "<leader>rh",
    \ "repl_restart": "<leader>rR",
    \ "repl_kill": "<leader>rk",
    \ "send_line": "<leader>sl",
    \ "send_visual": "<leader>sp",
    \ "send_paragraph": "<leader>sp",
    \ "send_until_cursor": "<leader>su",
    \ "send_file": "<leader>sf",
    \ "send_cancel": "<leader>sc",
    \ "send_blank_line": "<leader>s<CR>",
    \ }
  return defaults
endfunction
