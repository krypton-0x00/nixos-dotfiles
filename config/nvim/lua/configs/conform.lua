local options = {
  formatters_by_ft = {
    -- Lua
    lua = { "stylua" },

    -- C / C++
    c = { "clang-format" },
    cpp = { "clang-format" },

    -- Rust
    rust = { "rustfmt" },

    -- Nix
    nix = { "nixpkgs-fmt" },
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}

return options

