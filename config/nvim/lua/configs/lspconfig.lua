-- Load NvChad default LSP settings
require("nvchad.configs.lspconfig").defaults()

-- Enable LSP servers (NvChad + Neovim 0.10+ style)
local servers = {
  "html",
  "cssls",

  "clangd",        -- C / C++
  "rust_analyzer", -- Rust
  "nil_ls",        -- Nix
}

vim.lsp.enable(servers)

