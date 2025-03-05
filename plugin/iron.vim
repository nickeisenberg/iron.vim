"iron.vim is a minimal vim port of iron.nvim

" TODO: get this updated to actually overwite the default opts
function! s:UserOverwriteOpts()
  let opts = iron#defaults#defaults()
  return opts
endfunction

call iron#setup(s:UserOverwriteOpts())
