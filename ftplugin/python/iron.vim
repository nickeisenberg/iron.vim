function! Format(lines, kwargs)
  let exceptions = ["else", "elif", "except", "finally", "#"]
  let result = []

  if has_key(a:kwargs, "cmd")
    let cmd = kwargs["cmd"]
  endif 

  let indent_open = 0
  let insert_return = 0
  for line in a:lines
    if iron#helpers#string_is_empty(line) == 1
      continue
    endif

    if iron#helpers#string_is_indented(line) == 1
      let indent_open = 1

    elseif iron#helpers#starts_with_exception(line, exceptions)
      let indent_open = indent_open

    else
      if indent_open == 1
        let line = "\r" . line
        let indent_open = 0
      endif
    endif
  
    call add(result, line)
  endfor

  let formated_string = join(result, "\n") . "\n\r"
  return formated_string
endfunction
