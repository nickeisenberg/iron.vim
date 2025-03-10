function! s:Defaults()
  let defaults = {}
  let defaults["repl_debug_log"] = 0
  let defaults["repl_open_cmd"] = {
    \ 'vertical': iron#view#split('vertical rightbelow', 0.4),
    \ 'horizontal': iron#view#split('rightbelow', 0.25),
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


function! s:UserOverwriteOpts()
  let opts = s:Defaults()

  for key in keys(opts)
    if exists("g:iron_" . key)
      let opts[key] = eval("g:iron_" . key)
    endif
  endfor

  return opts
endfunction


call iron#setup(s:UserOverwriteOpts())
