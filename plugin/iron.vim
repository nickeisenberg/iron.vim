"iron.vim is a minimal vim port of iron.nvim

function! s:UserOverwriteOpts()
  let opts = iron#defaults#defaults()

  for key in keys(opts)
    if exists("g:" . key)
      let opts[key] = eval("g:" . key)
    endif
  endfor

  return opts
endfunction

call iron#setup(s:UserOverwriteOpts())
