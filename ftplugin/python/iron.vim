function! FormatPython(lines)
endfunction


local is_windows = require("iron.util.os").is_windows
local extend = require("iron.util.tables").extend

local cr = "\13"



--- @param lines table  "each item of the table is a new line to send to the repl"
--- @return table  "returns the table of lines to be sent the the repl with
-- the return carriage added"
common.bracketed_paste_python = function(lines, extras)
  local result = {}

  local cmd = extras["command"]
  local pseudo_meta = { current_buffer = vim.api.nvim_get_current_buf()}
  if type(cmd) == "function" then
    cmd = cmd(pseudo_meta)
  end

  local windows = is_windows()
  local python = false
  local ipython = false
  local ptpython = false

  if contains(cmd, "ipython") then
    ipython = true
  elseif contains(cmd, "ptpython") then
    ptpython = true
  else
    python = true
  end

  lines = remove_empty_lines(lines)

  local indent_open = false
  for i, line in ipairs(lines) do
    if string.match(line, "^%s") ~= nil then
      indent_open = true
    end

    table.insert(result, line)

    if windows and python or not windows then
      if i < #lines and indent_open and string.match(lines[i + 1], "^%s") == nil then
        if not python_close_indent_exceptions(lines[i + 1]) then
          indent_open = false
          table.insert(result, cr)
        end
      end
    end
  end

  local newline = windows and "\r\n" or cr
  if #result == 0 then  -- handle sending blank lines
    table.insert(result, cr)
  elseif #result > 0 and result[#result]:sub(1, 1) == " " then
    -- Since the last line of code is indented, the Python REPL
    -- requires and extra newline in order to execute the code
    table.insert(result, newline)
  else
    table.insert(result, "")
  end

  if ptpython then
    table.insert(result, 1, open_code)
    table.insert(result, close_code)
    table.insert(result, "\n")
  end

  return result
end


return common
