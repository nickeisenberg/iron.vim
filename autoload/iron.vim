function! iron#setup()
  let g:iron_repl_buf_id = -1
  let g:iron_repl_split_type = "vertical"
  
  if !empty($VIRTUAL_ENV)
    let python_def = "source $VIRTUAL_ENV/bin/activate && clear && which python3 && ipython"
  else
    let python_def = "ipython"
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

  nnoremap <leader>sp :silent! normal! vip<CR>:<C-u>call iron#core#send(getline("'<", "'>"))<CR>
  vnoremap <leader>sp :<C-u>call iron#core#send(getline("'<", "'>"))<CR>
  nnoremap <leader>sl :silent! normal! V<CR>:<C-u>call iron#core#send(getline("'<", "'>"))<CR>
  nnoremap <leader>su :silent! normal! mAVgg<CR>:<C-u>call iron#core#send(getline("'<", "'>"))<CR>`A
  nnoremap <leader>sf :silent! normal! mAggvG<CR>:<C-u>call iron#core#send(getline("'<", "'>"))<CR>`A
endfunction
