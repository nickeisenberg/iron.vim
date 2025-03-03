function! iron#setup()
  let g:iron_repl_buf_id = -1
  let g:iron_repl_split_type = "vertical"
  
  if !empty($VIRTUAL_ENV)
    let python_def = "source $VIRTUAL_ENV/bin/activate && clear && which python3 && python"
  else
    let python_def = "python3"
  endif
  
  let g:iron_repl_def = {
    \ 'sh': 'bash -l',
    \ 'vim': 'bash -l',
    \ 'python': python_def,
  \}
  
  let g:iron_repl_open_cmd = {
    \ 'vertical': 'vert rightbelow',
    \ 'horizontal': 'rightbelow',
  \}
  
  let g:iron_repl_size = {
    \ 'vertical': 0.4,
    \ 'horizontal': 0.25,
  \}
  
  nnoremap <leader>rr :call iron#core#toggle_repl('toggle')<CR>
  nnoremap <leader>rv :call iron#core#toggle_repl('vertical')<CR>
  nnoremap <leader>rh :call iron#core#toggle_repl('horizontal')<CR>
  xnoremap <leader>pp :<C-u>call iron#core#send(getline("'<", "'>"))<CR>
endfunction
