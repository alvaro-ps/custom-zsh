local M = {}

function M.setup()
  -- Require a OPENAI_API_KEY
  require('avante').setup({
    provider = 'openai',
    parse_api_key = function()
      local key = vim.env.OPENAI_API_KEY
      if not key then
        error('OPENAI_API_KEY environment variable is not set.')
      end
      return key
    end,
  })
end

return M
