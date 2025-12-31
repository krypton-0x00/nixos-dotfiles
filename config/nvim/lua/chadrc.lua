---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "gruvbox",
}

M.plugins = "custom.plugins"

M.configs = {
  lspconfig = {
    setup = "custom.configs.lspconfig",
  },

  conform = {
    setup = "custom.configs.conform",
  },
}

return M

