return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "vim", "vimdoc", "query",
        "python",
        "javascript", "typescript", "tsx",
        "json", "jsonc", "yaml", "toml",
        "markdown", "markdown_inline",
        "bash",
        "go", "rust", "c", "cpp",
        "matlab",
        "html", "css",
        "gitcommit", "gitignore", "diff",
        "regex",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection    = "<C-Space>",
          node_incremental  = "<C-Space>",
          scope_incremental = "<C-s>",
          node_decremental  = "<C-Backspace>",
        },
      },
    })
  end,
}
