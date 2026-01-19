local M = {}

function M.setup()
  require("mcphub").setup({
    extensions = {
        avante = {
            make_slash_commands = true,
        }
    }
  })
  -- Require a OPENAI_API_KEY
  require('avante').setup({
    --mode = 'legacy', -- for now as there is a bug, https://github.com/yetone/avante.nvim/issues/1939
    provider = 'openai',
    parse_api_key = function()
      local key = vim.env.OPENAI_API_KEY
      if not key then
        error('OPENAI_API_KEY environment variable is not set.')
      end
      return key
    end,
    -- system_prompt as function ensures LLM always has latest MCP server state
    -- This is evaluated for every message, even in existing chats
    system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
    end,
    -- Using function prevents requiring mcphub before it's loaded
    custom_tools = function()
        return {
            require("mcphub.extensions.avante").mcp_tool(),
        }
    end,
  })

  vim.g.opencode_opts = {
    -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition" on the type or field.
    provider = {
      enabled = "terminal",
    },
  }

  -- Required for `opts.events.reload`.
  vim.o.autoread = true
end

return M
