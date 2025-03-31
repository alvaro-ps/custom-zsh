local M = {}

function M.setup()
  local telescope = require("CopilotChat")
  telescope.setup({
    window = {
      layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
      width = 0.35, -- fractional width of parent, or absolute width in columns when > 1
      height = 1, -- fractional height of parent, or absolute height in rows when > 1
    },
  })
end

return M
