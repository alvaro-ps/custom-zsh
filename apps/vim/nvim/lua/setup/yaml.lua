local M = {}

function M.setup()
    require('lspconfig').yamlls.setup{
        on_attach=on_attach,
        settings = {
            yaml = {
                schemas = {
                    ["client_configs/schema/schema.json"]= "client_configs/*.yaml",
                }
            }
        }
    }
end

return M
