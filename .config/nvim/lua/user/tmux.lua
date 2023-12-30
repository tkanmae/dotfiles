M = {}

local TMUX_DIRECTION = { left = "L", right = "R", up = "U", down = "D" }

-- Execute tmux command.
local function tmux_command(command)
  local socket = vim.fn.split(vim.env.TMUX, ",")[1]
  return vim.fn.system("tmux -S " .. socket .. " " .. command)
end

-- Return true if the current pane is zoomed.
local function is_pane_zoomed()
  return tmux_command("display-message -p '#{window_zoomed_flag}'") == "1\n"
end

-- Select an adjacent pane.
function M.select_pane(direction)
  if not is_pane_zoomed() then
    tmux_command("select-pane -" .. TMUX_DIRECTION[direction])
  end
end

return M
